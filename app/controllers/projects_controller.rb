class ProjectsController < ApplicationController
  respond_to :json

  def index
    @projects = Project.all
    render :json => { projects: @projects }, :except => [:project_id, :created_at, :updated_at]
  end
end
