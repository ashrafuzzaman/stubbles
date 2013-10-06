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

  def link_to_time_entry_popup(task)
    link_to('', '#', :class => 'glyphicon glyphicon-calendar',
            :'popup-form' => true,
            :'popup-template' => 'time_entry_popup_template',
            :"popup-title" => 'Enter time for today',
            :'date' => Date.current,
            :'project_id' => task.story.project_id,
            :'task_id' => task.id,
            :'hours_spent' => task.total_hours_spent_on(Date.current),
            :'percent_completed' => task.percent_completed
    ) if task.permitted_to_enter_time_by?(current_user)
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