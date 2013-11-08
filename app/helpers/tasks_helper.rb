module TasksHelper
  def action_links_for_task(task)
    content_tag :div, class: 'task-actions' do
      if task.current_state.events.size > 0
        form_tag(update_status_story_task_path(task.story, task),
                 :method => :put, :remote => true) do
          task.current_state.events.keys.each do |event|
            concat(submit_tag(event, :name => 'event', :value => event.to_s.camelize,
                              :class => "task-#{event} btn btn-xs",
                              :'data-disable-with' => 'wait'))
          end
        end
      else
        content_tag :span, task.current_state.to_s, class: "btn btn-xs"
      end
    end
  end

  def task_edit_link(task)
    link_to('', edit_story_task_path(task.story, task),
            :remote => true, :class => 'glyphicon glyphicon-edit',
            :'data-disable-with' => "Loading...") if task.permitted_to_edit_by?(current_user)
  end

  def task_delete_link(task)
    link_to('', story_task_path(task.story, task),
            :remote => true, :class => 'glyphicon glyphicon-trash',
            :confirm => 'Are you sure?', :method => :delete,
            :'data-disable-with' => "Loading...") if task.permitted_to_delete_by?(current_user)
  end

  def hours_estimated_tag(form, task)
    form.text_field :hours_estimated, :disabled => !task.permitted_to_estimate_by?(current_user), class: 'form-control', placeholder: 'Est'
  end
end