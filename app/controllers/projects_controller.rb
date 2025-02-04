class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
    @page = params[:page].to_i.positive? ? params[:page].to_i : 1

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
