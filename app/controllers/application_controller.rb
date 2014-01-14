require 'auditlog/application_controller_helper'

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Auditlog::ApplicationControllerHelper
  before_filter :set_current_user
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def unauthorized_access
    flash[:error] = "Unauthorized access"
    redirect_to root_url
    false
  end

  protected
  def set_current_user
    User.current = current_user
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name

    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :short_name

  end
end