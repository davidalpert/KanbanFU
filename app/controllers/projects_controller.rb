class ProjectsController < ApplicationController
  respond_to :json

  def index
    @projects = Project.all
    respond_with(@projects)
  end
end
