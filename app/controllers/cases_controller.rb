class CasesController < ApplicationController
  def index
    @cases = Case.where(:case_set_id => params[:case_set_id])
  end
end
