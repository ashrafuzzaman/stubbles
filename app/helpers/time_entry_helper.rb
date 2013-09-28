module TimeEntryHelper
	def time_entry_slot_for(task, date)
		time_spent = task.total_hours_spent_on(date)
		if task.assigned_to == current_user
			content_tag(:span, time_spent, :class => 'time_entry editable',
				:'data-resource' => "Task", :'data-resource-id' => task.id,
				:'data-date' => date, :'data-project-id' => task.story.project_id)
		else
			time_spent
		end
	end

	def next_week_link
		link_to 'Next', time_entry_project_path(@project.id, :week => @week.next,
						:user_id => params[:user_id]),
						:class=>"button pull-right"
	end

	def prev_week_link
		link_to 'Previous', time_entry_project_path(@project.id, :week => @week.previous,
						:user_id => params[:user_id]),
						:class=>"button pull-left"
	end

	def time_entry_filter(project)
		user_filter('user_id', [:week]) if current_user.admin_for?(project)
	end

end