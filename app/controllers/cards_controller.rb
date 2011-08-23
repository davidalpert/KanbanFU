class CardsController < ApplicationController
  respond_to :json

  def index
    project = Project.find_by_id(params[:project_id])
    item = {cards: project.cards} if project
    render_json(item, :except => [:project_id])
  end
  
  def show
    card = Card.find_by_id(params[:id])
    item = {card: card} if card
    render_json(item, :except => [:project_id])
  end

  def create
    project = Project.find_by_id(params[:project_id])
    card = project.cards.create(params[:card])
    item = {card: card} if card
    render_json(item, :error_code => :bad_request)
  end

  def update
    project = Project.find_by_id(params[:project_id])
    card = project.cards.find_by_id(params[:id])
    item = {card: card} if card.update_attributes(params[:card])
    render_json(item, :error_code => :bad_request)
  end

  def destroy
    project = Project.find_by_id(params[:project_id])
    card = project.cards.find_by_id(params[:id])
    item = {} if card.destroy
    render_json(item, :error_code => :bad_request)
  end
end
