module StoriesHelper
  def assigned_person_for(model)
    model.assigned_to.nil? ? 'n/a' : model.assigned_to.name
  end
  
  def container_id_of_tasks_for(story)
    "#{container_id_of(story)}_tasks"
  end

  def action_links_for_story(story)
  	if (story.finished? || story.rejected?) && current_user.admin_for?(story.project)
  		form_tag(update_status_project_story_path(story.project, story), 
                    :method => :put, :remote=>true) do
  			story.current_state.events.keys.each do |event|
  				concat(submit_tag(event, :name => 'event', :value => event, 
                            :class => "#{event} button small",
                            :'data-disable-with' => 'wait'))
  			end
  		end
  	end
  end

  def select_users(form, story)
  	form.select(:assigned_to_id, 
							story.assignable_users.collect {|u| [u.name, u.id]},
  						:include_blank => true)
  end

  def select_story_type(form)
  	content_tag :div, :class => 'story_type' do
	  	StoryType.all.each do |story_type|
				concat(form.radio_button(:story_type, story_type))
				concat(form.label("story_type_#{story_type}", story_type))
			end
		end
  end

  def story_edit_link(story)
  	link_to('Edit', edit_project_story_path(story.project, story),
				:remote=>true, :class => 'ui-icon ui-icon-pencil', :style => 'float: left;',
				:'data-disable-with' => "Loading...") if story.permitted_to_edit_by?(current_user)
  end

  def story_delete_link(story)
	  link_to('Destroy', project_story_path(story.project, story), 
				:confirm => 'Are you sure?', :class => 'ui-icon ui-icon-trash',
				:method => :delete, :remote=>true, :style => 'float: left;',
				:'data-disable-with' => "Deleting...") if story.permitted_to_delete_by?(current_user)
  end

  def story_time_estimations(story)
  	render :partial => 'shared/estimated_and_spent_hours', 
					:locals => {:estimated => story.total_hours_estimated, 
								:spent => story.total_hours_spent}
  end

  def story_container(story)
  	concat <<-EOF.html_safe
    	<div id='#{container_id_of(story)}' class="story #{story.status} ui-widget ui-widget-content ui-helper-clearfix ui-corner-all">
  	EOF
  	yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

  def story_header()
  	concat <<-EOF.html_safe
    	<div class="story-header ui-widget-header ui-corner-all">
  	EOF
    yield
  	concat <<-EOF.html_safe
    	<span class="collapsable ui-icon ui-icon-triangle-1-s" style="float: left;"></span>
    	</div>
  	EOF
  end

  def story_content()
  	concat <<-EOF.html_safe
    	<div class="story-content ui-helper-hidden">
  	EOF
    yield
  	concat <<-EOF.html_safe
    	</div>
  	EOF
  end

end