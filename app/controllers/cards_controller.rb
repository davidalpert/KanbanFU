class CardsController < ApplicationController
  respond_to :json
  
  def index
    project = Project.find(params[:project_id])
    respond_to do |format|
      format.json do
        if project
          render :json => {cards: project.cards}, :except => [:project_id, :created_at, :updated_at]
        else
          render :json => @project.to_json, :status => 404
        end
      end
    end
  end

end
