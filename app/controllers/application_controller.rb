require 'auditlog/application_controller_helper'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Auditlog::ApplicationControllerHelper

  def unauthorized_access
    flash[:error] = "Unauthorized access"
    redirect_to root_url
    false
  end
end