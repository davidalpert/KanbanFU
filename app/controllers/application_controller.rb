class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def render_json(item, status = item ? :ok : 404)
      render :json => item,                                       \
             :status => status,                                   \
             :except => [:project_id, :created_at, :updated_at]
    end
end
