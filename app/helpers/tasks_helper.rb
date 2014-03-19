module TasksHelper
  def action_links_for_task(task)
    unless task.story.milestone.try(:archived?)
      content_tag :div, class: 'status-button' do
        if task.workflow_status
          field_id = "task-#{task.id}-event-action"
          form_tag(update_status_story_task_path(task.story, task),
                   :method => :put, :remote => true) do
            concat(hidden_field_tag :workflow_status_id, '', id: field_id)
            task.allowable_workflow_transitions.each do |transition|
              concat(submit_tag(transition.event, :value => transition.event,
                                onclick: "$('##{field_id}').val('#{transition.to_status_id}');",
                                :class => "task-#{transition.button_color} btn btn-xs",
                                :'data-disable-with' => 'wait'))
            end
          end
        end
      end
    end
  end

  def task_edit_link(task)
    unless task.story.milestone.try(:archived?)
      link_to('', edit_story_task_path(task.story, task),
              :remote => true, :class => 'glyphicon glyphicon-edit edit',
              :'data-disable-with' => "Loading...")
    end
  end

  def task_delete_link(task)
    unless task.story.milestone.try(:archived?)
      link_to('', story_task_path(task.story, task),
              :remote => true, :class => 'glyphicon glyphicon-trash delete',
              :confirm => 'Are you sure?', :method => :delete,
              :'data-disable-with' => "Loading...")
    end
  end

  def link_to_new_task_for(story)
    unless story.milestone.try(:archived?)
      link_to('New Task', 'javascript:void(0)', :class => 'btn btn-primary btn-xs', :'data-story-id' => story.id,
              :'render-template' => 'new-task-template', :'append-after' => "##{container_id_of_tasks_for(story)} .tasks",
              after_append_call: 'Task.new') unless story.sealed_for_tasks?
    end
  end

  def hours_estimated_tag(form, task)
    form.text_field :hours_estimated, :disabled => !task.permitted_to_estimate_by?(current_user), class: 'form-control', placeholder: 'Est'
  end
end