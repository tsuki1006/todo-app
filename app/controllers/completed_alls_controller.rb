class CompletedAllsController < ApplicationController
  def destroy
    Task.completed_all_destroy
    redirect_to root_path(type: @type)
  end
end
