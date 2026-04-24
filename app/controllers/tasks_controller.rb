class TasksController < ApplicationController
  before_action :set_task, only: [ :edit, :update ]
  before_action :set_filter_type, only: [ :index, :create, :edit, :update ]

  def index
    @uncompleted_tasks = Task.uncompleted.order(:deadline).order(:created_at)
    @completed_tasks = Task.completed.order(updated_at: :desc).order(:created_at)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path(type: @type)
    else
      @uncompleted_tasks = Task.uncompleted.order(:deadline).order(:created_at)
      @completed_tasks = Task.completed.order(updated_at: :desc).order(:created_at)
      flash.now[:error] = 'タスクの追加に失敗しました'
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      @uncompleted_tasks = Task.uncompleted.order(:deadline).order(:created_at)
      @completed_tasks = Task.completed.order(updated_at: :desc).order(:created_at)
      flash.now[:notice] = 'タスクを更新しました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    type = params[:type] if params[:type].present?
    task = Task.find(params[:id])
    task.destroy!
    redirect_to root_path(type: type), notice: '削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def set_filter_type
    @type = params[:type] if params[:type].present?
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline,
    )
  end
end
