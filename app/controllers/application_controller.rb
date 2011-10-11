class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_simulation_date
  
  def current_date
    respond_to do |format|
      format.js do
        session[:simulation_date] = DateTime.parse(params['date'])
        render nothing: true
      end
    end
  end
  
  private
    def set_simulation_date
      TimeProvider.current_time = session[:simulation_date]
    end
    
    def render_json(item, options = {})
      options.reverse_merge! :except => [], :error_code => :not_found

      status = item ? :ok : options[:error_code]
      render :json => item,
        :status => status,
        :except => options[:except] + [:created_at, :updated_at]
    end

    def render_not_found(message = 'Not Found')
      render :json => {:message => message}, :status => :not_found
    end

    def resource_found?(object, &block)
      if object
        block.call
      else
        render_not_found
      end
    end

end
