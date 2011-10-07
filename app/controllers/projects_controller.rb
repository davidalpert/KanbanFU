class ProjectsController < ApplicationController
  respond_to :html, :json

  def index
    render_json({projects: Project.all})
  end

  def show
    @project = Project.find_by_id(params[:id])
    respond_with(@project) do |format|
      format.json { render_json({project: @project}) }
    end
  end

  def create
    project = Project.new(params[:project])
    project.save
    render_json({project: project})
  end
end
