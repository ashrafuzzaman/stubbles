class ApplicationController < ActionController::Base
  protect_from_forgery

  def unauthorized_access
    flash[:error] = "Unauthorized access"
    redirect_to root_url
    false
  end
end