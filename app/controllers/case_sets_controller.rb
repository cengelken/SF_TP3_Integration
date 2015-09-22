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
    @case_set = CaseSet.create(case_set_params)
    redirect_to case_set_path(@case_set.id)
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_set_params
      #params.require("case_set").permit("cases_attributes": ["case_num","description","owner","url"])
      params.require(:case_set).permit(cases_attributes: [:case_num,:description,:owner,:url])
    end
end
