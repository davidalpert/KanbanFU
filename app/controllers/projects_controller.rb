class ProjectsController < ApplicationController
  respond_to :html, :json, :js

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

  def move_card
    respond_to do |format|
      format.js do
        moved_card = Card.find_by_id params[:card_id]
        phase = Phase.find_by_id params[:phase_id]
        moved_card.update_attribute :phase_id, phase.id
        render nothing: true
      end
    end
  end
end
