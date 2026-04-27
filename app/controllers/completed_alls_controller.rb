class CompletedAllsController < ApplicationController
  def destroy
    completed_tasks = Task.completed
    completed_tasks.destroy_all
    redirect_to root_path(type: @type)
  end
end
