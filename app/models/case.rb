class Case < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  validates :case_num, :presence => true
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def self.get_salesforce_cases(user)
    client = Restforce.new :oauth_token => user.oauth_token,
     :refresh_token => user.refresh_token,
     :instance_url  => user.instance_url,
     :client_id     => ENV['SALESFORCE_KEY'],
     :client_secret => ENV['SALESFORCE_SECRET'] 

    raw_cases = client.query("SELECT Id, CaseNumber, Subject, Owner.Name,
     (SELECT Short_Description__c,Next_Action__c,Action_Due_Date__c,Action_Owner__c 
     FROM Support_Action_Plans__r) FROM Case 
     WHERE ((Escalation_Type__c='Tier 1 - Escalation') 
     AND (Status NOT IN ('7 - Close Pending Customer','8 - Closed')))")

    build_case_set_hash(raw_cases.as_json)
  end

  def self.build_case_set_hash(case_json)
    return_string =  "{:case_set=>"
    case_json.each do |case_obj| 
      return_string += ":case_attributes=>[{" +
                       ":case_num=>#{case_obj["CaseNumber"]}," +
                       ":url=>'https://meraki.my.salesforce.com/' + #{case_obj["Id"]}" +

    end
    return_string
  end
end
