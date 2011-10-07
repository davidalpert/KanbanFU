class CardsController < ApplicationController
  respond_to :json
  before_filter :get_project, :except => [:show, :edit]

  def index
    item = { cards: adjust(@project.cards) } if @project
    render_json(item, :except => exceptions)
  end
  
  def show
    card = Card.find_by_id(params[:id])
    item = { card: adjust(card) } if card
    render_json(item, :except => exceptions)
  end

  def create
    resource_found?(@project) do 
      card = @project.cards.create(params[:card])
      item = { card: adjust(card) } if card
      render_json(item, :error_code => :bad_request, except: exceptions)
    end
  end

  def update
    resource_found?(@project) do
      card = @project.cards.find_by_id(params[:id])
      item = { card: adjust(card) } if card.update_attributes(params[:card])
      render_json(item, :error_code => :bad_request, except: exceptions)
    end
  end

  def destroy
    resource_found?(@project) do
      card = @project.cards.find_by_id(params[:id])
      item = {} if card.destroy
      render_json(item, :error_code => :bad_request)
    end
  end

  private
    def get_project
      @project = Project.find_by_id(params[:project_id])
    end
  
    def adjust(cards)
      adjusted = [cards].flatten.collect { |c| c.attributes.merge(phase: c.phase.name) }
      return adjusted if cards.kind_of? Array
      adjusted.first
    end
    
    def exceptions
      ['project_id', 'created_at', 'updated_at', 'phase_id']
    end
end
