class WholeCompletionsController < ApplicationController
  def create
    uncompleted_tasks = Task.uncompleted
    uncompleted_tasks.update_all(completed: true)
    redirect_to root_path
  end

  def destroy
    completed_tasks = Task.completed
    completed_tasks.update_all(completed: false)
    redirect_to root_path
  end
end
