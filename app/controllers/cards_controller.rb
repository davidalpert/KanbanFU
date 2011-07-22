class CardsController < ApplicationController
  respond_to :json

  def index
    project = Project.find(params[:project_id])
    item = {cards: project.cards} if project
    render_json(item)
  end
  
  def show
    card = Card.find(params[:id])
    item = {card: card} if card
    render_json(item)
  end
end
