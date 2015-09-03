class TasksController < ApplicationController
  def index
    @tasks = Task.where(:case_id => params[:case_id])
  end
end
