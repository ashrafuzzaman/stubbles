module MilestonesHelper
  def milestone_filter(project, milestone)
    form_tag("", :method => :get) do |f|
      concat select_tag(:milestone_id, options_for_select(project.milestones.collect { |m| [m.title, m.id] },
                                                          :selected => milestone.try(:id)),
                        {:class => 'submittable form-control', :prompt => 'Backlog'})
      [:involved_with].each do |param|
        concat hidden_field_tag param, params[param]
      end
    end
  end

  def move_milestone_list(project)
    select_tag(:move_milestone_id, options_for_select(project.milestones.collect { |m| [m.title, m.id] },
                                                      :selected => params[:milestone_id]),
               {:class => 'form-control', :prompt => 'Assign milestone', :'data-selected' => params[:milestone_id]})
  end

  def milestone_assignment_status_class(milestone, resource)
    case milestone.assignment_status_for(resource)
      when :available then
        'success'
      when :filled
        'active'
      when :not_available
        'warning'
      when :busy then
        'danger'
    end
  end
end