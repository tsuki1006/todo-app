class CompletionsController < ApplicationController
  def update
    task = Task.find(params[:task_id])
    task.update!(completed: params[:task][:completed])
    redirect_to root_path(type: @type)
  end
end
