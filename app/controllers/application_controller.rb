require 'auditlog/application_controller_helper'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Auditlog::ApplicationControllerHelper
  before_filter :set_current_user

  def unauthorized_access
    flash[:error] = "Unauthorized access"
    redirect_to root_url
    false
  end

  private
  def set_current_user
    User.current = current_user
  end
end