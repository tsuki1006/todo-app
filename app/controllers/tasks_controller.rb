class TasksController < ApplicationController
  before_action :set_task, only: [ :edit, :update ]

  def index
    @tasks = Task.all.order(:deadline).order(:created_at)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path, notice: 'タスクを追加しました'
    else
      flash.now[:error] = 'タスクの追加に失敗しました'
      @tasks = Task.all
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to edit_task_path(@task), notice: 'タスクを更新しました'
    else
      flash.now[:error] = 'タスクの更新に失敗しました'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy!
    redirect_to root_path, notice: '削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :title,
      :content,
      :deadline,
    )
  end
end
