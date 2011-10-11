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
        update_life_cycle(moved_card, phase)
        render nothing: true
      end
    end
  end
  private 
    def update_life_cycle(card, phase)
      start_life_cycle(card) unless phase.is_backlog
      stop_life_cycle(card) if phase.is_archive

      clear_finish(card) unless phase.is_archive 
      clear_life_cycle(card) if phase.is_backlog
    end
    
    def clear_life_cycle(card)
      card.update_attribute(:started_on, nil)
      card.update_attributes(waiting_time: 0, blocked_time: 0)
    end

    def clear_finish(card)
      card.update_attribute(:finished_on, nil) if card.finished_on
    end

    def start_life_cycle(card)
      card.update_attribute(:started_on, TimeProvider.current_time) unless card.started_on
    end
    
    def stop_life_cycle(card)
      card.update_attribute :finished_on, TimeProvider.current_time
    end
end
