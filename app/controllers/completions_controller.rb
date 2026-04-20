class CompletionsController < ApplicationController
  def update
    task = Task.find(params[:task_id])
    task.update!(task_params)
    redirect_to root_path
  end

  private
  def task_params
    params.require(:task).permit(:completed)
  end
end
