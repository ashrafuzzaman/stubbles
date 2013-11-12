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

  def link_to_time_entry_popup(task, date=Date.current, show_detail = false)
    time_entry = task.time_entry_for(current_user, date)
    if show_detail
      concat content_tag :span, time_entry.try(:hours_spent) || 0, class: 'hours_spent'
      concat progress_bar_with_percent(time_entry.try(:percent_completed).to_i)
    end
    if task.permitted_to_enter_time_by?(current_user)
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
            :class => "btn btn-primary pull-right"
  end

  def prev_week_link
    link_to 'Previous', weekly_time_entry_path(@project.id, :week => @week.previous,
                                               :user_id => params[:user_id]),
            :class => "btn btn-primary pull-left"
  end

end