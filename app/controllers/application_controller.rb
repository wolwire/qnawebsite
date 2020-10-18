class ApplicationController < ActionController::Base
  include SessionsHelper
  include ActionController::Live
  include ApplicationHelper
  rescue_from ActionController::RoutingError, with: -> { render_404  }

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
  def render_404
    respond_to do |format|
      format.html { render template: 'errors/not_found', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

end
