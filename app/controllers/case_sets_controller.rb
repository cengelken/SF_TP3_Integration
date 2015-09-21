class CaseSetsController < ApplicationController

  def index
    @case_sets = CaseSet.all
  end

  def show
    @cases = Case.where(:case_set_id=> params[:id])
  end

  def new
    @cases = Case.get_salesforce_cases(current_user)
  end

  def create
    @case_set = CaseSet.new(case_set_params)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
#    def case_set_params
#      params[:case_set]
#    end
end
