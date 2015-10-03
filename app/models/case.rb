class Case < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  validates :case_num, :presence => true
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def self.get_salesforce_cases(user)
    @client = Restforce.new :oauth_token => user.oauth_token,
     :refresh_token => user.refresh_token,
     :instance_url  => user.instance_url,
     :client_id     => ENV['SALESFORCE_KEY'],
     :client_secret => ENV['SALESFORCE_SECRET'] 

    raw_cases = @client.query("SELECT Id, CaseNumber, Subject, Owner.Name, Owner.Email,
     (SELECT Next_Action__c,Action_Due_Date__c,Action_Owner__c 
     FROM Support_Action_Plans__r) FROM Case 
     WHERE ((Escalation_Type__c='Tier 1 - Escalation') 
     AND (Status NOT IN ('7 - Close Pending Customer','8 - Closed')))")
    build_case_set_hash(raw_cases)
  end

  def self.push_to_tp3(case_set)
    # figure out what doesn't have a tp3_id or has changed
    case_set.cases.each do |case_obj|
      if case_obj.tp3_id.nil?
        project_response = HTTParty.post(ENV['TARGETPROCESS_URL']+'Projects', :headers => { 'Content-Type' => 'application/json' }, :body => { 'Name' => "#{case_obj.case_num}" }.to_json, :query => {format: "json", token: ENV['TARGETPROCESS_API_KEY']})
        # should check if the post fails
        case_obj.update(tp3_id: "#{project_response.parsed_response["Id"]}")
        if case_obj.tasks
          case_obj.tasks.each do |task_obj|
            task_response = HTTParty.post(ENV['TARGETPROCESS_URL']+'UserStories', :headers => { 'Content-Type' => 'application/json' }, :body => { 'Name' => "#{task_obj.next_action}", "Project"=>{"Id"=>"#{case_obj.tp3_id}"} }.to_json, :query => {format: "json", token: ENV['TARGETPROCESS_API_KEY']})
            task_obj.update(tp3_id: "#{task_response.parsed_response["Id"]}")
          end
        end
      end
    end
    # push to tp3
    # get the tp3_id if needed
    # else display success via flash notice
  end

  def self.build_case_set_hash(case_collection)
    #return_hash = Hash.new
    escalation_engineers = get_current_esc_engineers
    return_string = "{:case_set=>"
    return_string += "{:cases_attributes=>["
    case_collection.each do |case_obj| 
      if escalation_engineers.include?("#{case_obj.Owner.Email}")
        return_string += "{:case_num=>\"#{case_obj.CaseNumber}\"," +
                         ":url=>\"https://meraki.my.salesforce.com/#{case_obj.Id}\"," +
                         ":description=>\"#{case_obj.Subject.gsub(/[^0-9A-Za-z ]/, '')}\"," +
                         ":owner=>\"#{case_obj.Owner.Name}\""
                         # tasks_attributes addition in the hash are here
                         if case_obj.Support_Action_Plans__r
                           return_string += ",:tasks_attributes=>["
                             case_obj.Support_Action_Plans__r.each do |task_obj|
                               return_string += "{:owner=>\"#{task_obj.Action_Owner__c}\"," +
                                                ":due_date=>\"#{task_obj.Action_Due_Date__c}\"," +
                                                ":next_action=>\"#{task_obj.Next_Action__c}\","
                             end
                           return_string += "},]"
                         end
        return_string += "},"
      end
    end
    return_string += "]}}"
    Rails.logger.debug "#{return_string}"
    eval(return_string)
  end

  def self.get_current_esc_engineers
    esc_array = []
    results = @client.query("SELECT Id, Email FROM User WHERE UserRole.Name='Escalation Engineer'")
    results.each do |engineer_email|
      esc_array.push(engineer_email.Email)
    end
    esc_array
  end
end
