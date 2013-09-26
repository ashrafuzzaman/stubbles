module ProjectsHelper
  def user_filter(param_name)
    form_tag("", :method => :get) do |f|
      concat select_tag(param_name, options_for_select(@project.collaborators.collect { |user| [user.name, user.id] },
                                                       :selected => params[param_name]),
                        {:class => 'submittable form-control', :prompt => 'For all user'})
      [:milestone_id].each do |param|
        concat hidden_field_tag param, params[param]
      end
    end
  end

  def dashboard_path_for(project, user)
    if user.admin_for?(project)
      project_dashboard_path(project.id)
    else
      project_dashboard_path(project.id, :involved_with => user.id)
    end
  end
end