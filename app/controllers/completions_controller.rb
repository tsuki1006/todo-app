class CompletionsController < ApplicationController
  def update
    type = params[:type] if params[:type].present?
    task = Task.find(params[:task_id])
    task.update!(task_params)
    redirect_to root_path(type: type)
  end

  private
  def task_params
    params.require(:task).permit(:completed)
  end
end
