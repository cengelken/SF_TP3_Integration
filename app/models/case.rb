class Case < ActiveRecord::Base
  belongs_to :case_set
  has_many :tasks
  validates :case_num,:case_set_id, :presence => true

  def self.get_salesforce_cases(user, set_id)
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

    case_array = JSON.parse(raw_cases.to_json)
    case_hash = {}
    task_hash = {}
    @cases = []
    @tasks = []

    case_array.each do |case_obj|
      case_hash[:case_set_id] = set_id
      case_hash[:case_num] = case_obj["CaseNumber"] 
      case_hash[:url] = "https://meraki.my.salesforce.com/" + case_obj["Id"] 
      case_hash[:description] = case_obj["Subject"]
      case_hash[:owner] = case_obj["Owner"]["Name"]
      new_case = Case.create(case_hash)
      @cases.push(new_case)
    end
    @cases
  end
end
