class WholeCompletionsController < ApplicationController
  def create
    Task.change_whole_completion_to(true)
    redirect_to root_path(type: @type)
  end

  def destroy
    Task.change_whole_completion_to(false)
    redirect_to root_path(type: @type)
  end
end
