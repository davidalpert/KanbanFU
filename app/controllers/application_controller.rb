class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def render_json(item, options = {})
      options.reverse_merge! :except => [], :error_code => :not_found

      status = item ? :ok : options[:error_code]
      render :json => item,
             :status => status,
             :except => options[:except] + [:created_at, :updated_at]
    end
end
