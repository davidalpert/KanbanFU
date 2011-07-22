class ProjectsController < ApplicationController
  respond_to :json

  def index
    render_json({ projects: Project.all })
  end
end
