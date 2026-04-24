class TasksController < ApplicationController
  before_action :set_task, only: [ :edit, :update ]
  before_action :set_filter_type

  def index
    set_tasks_for_list
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path(type: @type)
    else
      set_tasks_for_list
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      set_tasks_for_list
      flash.now[:notice] = 'タスクを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!

    set_tasks_for_list
    flash.now[:notice] = 'タスクを削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_filter_type
    @type = params[:type] if params[:type].present?
  end

  def set_tasks_for_list
    @uncompleted_tasks = Task.uncompleted.order(:deadline).order(:created_at)
    @completed_tasks = Task.completed.order(updated_at: :desc).order(:created_at)
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline,
    )
  end
end
