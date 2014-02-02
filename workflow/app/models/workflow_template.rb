class WorkflowTemplate
  @@default_template = {'Feature' =>
                            {default_color: 'default',
                             statuses: [
                                 {title: 'Open', default_color: 'default', allow_to_estimate: true, allow_to_delete: true},
                                 {title: 'In progress', default_color: 'default', propagate_color_if_any: true, allow_to_enter_time: true},
                                 {title: 'Done', default_color: 'default'},
                                 {title: 'Deployed to test', default_color: 'default'},
                                 {title: 'Qa approved', default_color: 'default'},
                                 {title: 'Deployed to production', default_color: 'default'},
                                 {title: 'Closed', default_color: 'default'},
                             ],
                             transitions: [{event: 'Start', from: 'Open', to: 'In progress', button_color: 'yellow'},
                                           {event: 'Done', from: 'In progress', to: 'Done', button_color: 'green'},
                                           {event: 'Deploy to test', from: 'Done', to: 'Deployed to test', button_color: 'default'},
                                           {event: 'Ready to deploy', from: 'Deployed to test', to: 'Qa approved', button_color: 'green'},
                                           {event: 'Reject', from: 'Deployed to test', to: 'Open', button_color: 'red'},
                                           {event: 'Deploy to production', from: 'Qa approved', to: 'Deployed to production', button_color: 'default'},
                                           {event: 'Close', from: 'Deployed to production', to: 'Closed', button_color: 'default'}
                             ]},
                        'Bug' =>
                            {default_color: 'red',
                             statuses: [
                                 {title: 'Open', default_color: 'default', allow_to_estimate: true, allow_to_delete: true},
                                 {title: 'In progress', default_color: 'default', propagate_color_if_any: true, allow_to_enter_time: true},
                                 {title: 'Done', default_color: 'default'},
                                 {title: 'Deployed to test', default_color: 'default'},
                                 {title: 'Qa approved', default_color: 'default'},
                                 {title: 'Deployed to production', default_color: 'default'},
                                 {title: 'Closed', default_color: 'default'},
                             ],
                             transitions: [{event: 'Start', from: 'Open', to: 'In progress', button_color: 'yellow'},
                                           {event: 'Done', from: 'In progress', to: 'Done', button_color: 'green'},
                                           {event: 'Deploy to test', from: 'Done', to: 'Deployed to test', button_color: 'default'},
                                           {event: 'Ready to deploy', from: 'Deployed to test', to: 'Qa approved', button_color: 'green'},
                                           {event: 'Reject', from: 'Deployed to test', to: 'Open', button_color: 'red'},
                                           {event: 'Deploy to production', from: 'Qa approved', to: 'Deployed to production', button_color: 'default'},
                                           {event: 'Close', from: 'Deployed to production', to: 'Closed', button_color: 'default'}
                             ]},
                        'Test case' =>
                            {default_color: 'default',
                             statuses: [
                                 {title: 'Open', default_color: 'default', allow_to_delete: true},
                                 {title: 'Passed', default_color: 'green', propagate_color_if_all: true},
                                 {title: 'Failed', default_color: 'red', propagate_color_if_any: true}
                             ],
                             transitions: [{event: 'Pass', from: 'Open', to: 'Passed', button_color: 'green'},
                                           {event: 'Fail', from: 'Open', to: 'Failed', button_color: 'red'}
                             ]}
  }

  def initialize(project, template=nil)
    @template, @project = (template || @@default_template), project
  end

  def create_workflow!
    @template.keys.each do |story_type_title|
      create_workflow_for_story_type(story_type_title)
    end
  end

  private
  def create_workflow_for_story_type(story_type_title)
    story_type = @project.story_types.find_or_initialize_by(title: story_type_title)
    story_type.default_color = @template[story_type_title][:default_color]
    story_type.save

    status_map = status_map_for(story_type)

    @template[story_type_title][:transitions].each do |transition_hash|
      transition = story_type.workflow_transitions.find_or_initialize_by(event: transition_hash[:event])
      transition.from_status_id = status_map[transition_hash[:from]]
      transition.to_status_id = status_map[transition_hash[:to]]
      transition.button_color = status_map[transition_hash[:button_color]]
      transition.save
    end
  end

  def status_map_for(story_type)
    statuses = @template[story_type.title][:statuses]
    status_map = {}
    statuses.each_with_index do |status_attributes, i|
      status = story_type.workflow_statuses.find_or_initialize_by(title: status_attributes[:title])
      status.attributes = status_attributes
      status.initial_status = i == 0
      status.save
      status_map[status.title] = status.id
    end
    status_map
  end
end