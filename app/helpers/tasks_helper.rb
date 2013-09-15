module TasksHelper
  def action_links_for_task(task)
  	content_tag :div, :style => 'float: left;' do
  		form_tag(update_status_story_task_path(task.story, task), 
                    :method => :put, :remote=>true) do
  			task.current_state.events.keys.each do |event|
  				concat(submit_tag(event, :name => 'event', :value => event, 
                            :class => "#{event} button small",
                            :'data-disable-with' => 'wait'))
  			end
  		end
  	end
  end

  def task_edit_link(task)
  	link_to('Edit', edit_story_task_path(task.story, task), 
				:remote=>true, :class => 'ui-icon ui-icon-pencil', :style => 'float: left;',
				:'data-disable-with' => "Loading...") if task.permitted_to_edit_by?(current_user)
  end

  def task_delete_link(task)
  	link_to('Destroy', story_task_path(task.story, task), 
				:confirm => 'Are you sure?', :style => 'float: left;', 
				:method => :delete, :class => 'ui-icon ui-icon-trash', :remote=>true, 
				:'data-disable-with' => "Deleting...") if task.permitted_to_delete_by?(current_user)
  end

  def hours_estimated_tag(form, task)
		form.text_field :hours_estimated, :size => '1', :disabled => !task.permitted_to_estimate_by?(current_user)
  end
end