class CasesController < ApplicationController
  def index
    @case_set = Case.group(:case_set_id).count
  end

  def show
    @case = Case.find(params[:id])
  end
end
