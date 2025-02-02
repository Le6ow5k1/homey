class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @history = @project.conversation_history(
      page: params[:page].to_i.positive? ? params[:page].to_i : 1
    )
  end
end 