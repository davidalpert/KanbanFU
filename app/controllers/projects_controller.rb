class ProjectsController < ApplicationController
  respond_to :json

  def index
    render_json({projects: Project.all})
  end
  
  def show
    render_json({project: Project.find(params[:id])})
  end
      
  def create
    project = Project.new(params[:project])
    project.save
    render_json({project: project})
  end
end
