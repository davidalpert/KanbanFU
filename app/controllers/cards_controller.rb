class CardsController < ApplicationController
  respond_to :json

  def index
    project = Project.find(params[:project_id])
    item = {cards: project.cards} if project
    status = project ? :ok : 404
    render :json => item, :status => status, :except => [:project_id, :created_at, :updated_at]
  end
  
  def show
    card = Card.find(params[:id])
    item = {card: card} if card
    status = card ? :ok : 404
    render :json => item, :status => status, :except => [:project_id, :created_at, :updated_at]
  end
end
