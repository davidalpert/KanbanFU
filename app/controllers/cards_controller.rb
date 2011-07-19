class CardsController < ApplicationController
  respond_to :json
  
  def index
    project = Project.find(params[:project_id])
    
    respond_to do |format|
      format.json do
        item = {cards: project.cards} if project
        status = project ? :ok : 404
        render :json => item, :status => status, :except => [:project_id, :created_at, :updated_at]
      end
    end
  end

end
