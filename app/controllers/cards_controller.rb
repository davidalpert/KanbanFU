class CardsController < ApplicationController
  respond_to :json
  
  def index
    project = Project.find(params[:project_id])
    if project
      respond_with({cards: project.cards}, :status => :ok)
    else
      respond_with(@project.to_json, :status => 404)
    end
  end

end
