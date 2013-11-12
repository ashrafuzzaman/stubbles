module TimeEntryHelper
  def time_entry_slot_for(task, date)
    time_spent = task.total_hours_spent_on(date)
    if task.assigned_to == current_user
      content_tag(:span, time_spent, :class => 'time_entry editable',
                  :'data-task-id' => task.id,
                  :'data-date' => date, :'data-project-id' => task.story.project_id)
    else
      time_spent
    end
  end

  def link_to_time_entry_popup(task, date=Date.current)
    if task.permitted_to_enter_time_by?(current_user)
      time_entry = task.time_entry_for(current_user, date)
      link_to('', 'javascript:void(0)', :class => 'glyphicon glyphicon-calendar',
              :'popup-form' => true,
              :'popup-template' => 'time_entry_popup_template',
              :"popup-title" => 'Enter time for today',
              :'date' => date,
              :'project_id' => task.story.project_id,
              :'task_id' => task.id,
              :'hours_spent' => time_entry.try(:hours_spent),
              :'percent_completed' => time_entry.try(:percent_completed)
      )
    end
  end

  def next_week_link
    link_to 'Next', weekly_time_entry_path(@project.id, :week => @week.next,
                                           :user_id => params[:user_id]),
            :class => "button pull-right"
  end

  def prev_week_link
    link_to 'Previous', weekly_time_entry_path(@project.id, :week => @week.previous,
                                               :user_id => params[:user_id]),
            :class => "button pull-left"
  end

  def time_entry_filter(project)
    user_filter('user_id', [:week]) if current_user.admin_for?(project)
  end

end