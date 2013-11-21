module TasksHelper
  def action_links_for_task(task)
    content_tag :div, class: 'status-button' do
      if task.current_state.events.size > 0
        field_id = "task-#{task.id}-event-action"
        form_tag(update_status_story_task_path(task.story, task),
                 :method => :put, :remote => true) do
          concat(hidden_field_tag :event, '', id: field_id)
          task.current_state.events.keys.each do |event|
            concat(submit_tag(event, :value => event.to_s.humanize,
                              onclick: "$('##{field_id}').val('#{event.to_s}');",
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
            :remote => true, :class => 'glyphicon glyphicon-edit edit',
            :'data-disable-with' => "Loading...")
  end

  def task_delete_link(task)
    link_to('', story_task_path(task.story, task),
            :remote => true, :class => 'glyphicon glyphicon-trash delete',
            :confirm => 'Are you sure?', :method => :delete,
            :'data-disable-with' => "Loading...")
  end

  def hours_estimated_tag(form, task)
    form.text_field :hours_estimated, :disabled => !task.permitted_to_estimate_by?(current_user), class: 'form-control', placeholder: 'Est'
  end
end