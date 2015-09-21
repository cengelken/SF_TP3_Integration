class CasesController < ApplicationController
  def index
    @case_set = Case.group(:case_set_id).count
  end
end
