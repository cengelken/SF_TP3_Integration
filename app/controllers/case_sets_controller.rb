class CaseSetsController < ApplicationController
  def index
    @case_sets = CaseSet.all
  end

  def new
    @case_set = CaseSet.create
    @cases = Case.get_salesforce_cases(current_user, @case_set.id)
  end

  def create
  end

  def destroy
    CaseSet.find(params[:id]).destroy
    redirect_to root_url
  end
end
