class ApplicationController < ActionController::Base
  protect_from_forgery

  def unauthorized_access
		flash[:error] = "Unauthorized access"
		redirect_to root_url
		false
  end

private 
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
    	project = resource.default_project
      project ? view_context.dashboard_path_for(project, current_user) : super
    else
      super
    end
  end
end