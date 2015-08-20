require 'test_helper'

class CaseSetTest < ActiveSupport::TestCase
  test "should create a new case set" do 
    case_set = CaseSet.new
    assert case_set.save
  end
  
  test "should log in to Salesforce via omniauth-salesforce gem" do

end
