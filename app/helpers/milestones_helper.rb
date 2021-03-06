module MilestonesHelper
  def milestone_filter(project, milestone)
    milestones = project.cached_milestones.collect { |m| [m.title, m.id] }
    milestones.insert 0, ['Backlog', 0]
    form_tag("", :method => :get, remote: true, :'show-loading-image' => '#loading-placeholder') do |f|
      concat select_tag(:milestone_id, options_for_select(milestones, :selected => (milestone.try(:id) || params[:milestone_id])),
                        {:class => 'submittable form-control', :prompt => 'All'})
      [:involved_with].each do |param|
        concat hidden_field_tag param, params[param]
      end
    end
  end

  def move_milestone_list(project)
    milestone_id = @milestone.try(:id) || params[:milestone_id]
    select_tag(:action_milestone_id, options_for_select(project.cached_milestones.collect { |m| [m.title, m.id] },
                                                        :selected => milestone_id),
               {:class => 'form-control', :prompt => 'Assign milestone', :'data-selected' => milestone_id})
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