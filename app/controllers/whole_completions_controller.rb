class WholeCompletionsController < ApplicationController
  def create
    type = params[:type] if params[:type].present?
    uncompleted_tasks = Task.uncompleted
    uncompleted_tasks.update_all(completed: true)
    redirect_to root_path(type: type)
  end

  def destroy
    type = params[:type] if params[:type].present?
    completed_tasks = Task.completed
    completed_tasks.update_all(completed: false)
    redirect_to root_path(type: type)
  end
end
