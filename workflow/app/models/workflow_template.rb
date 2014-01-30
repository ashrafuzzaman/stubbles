class WorkflowTemplate
  @@default_template = {'Feature' =>
                            {'Start' => {'Open' => 'In progress'},
                             'Done' => {'In progress' => 'Done'},
                             'Deploy to test' => {'Done' => 'Deployed to test'},
                             'Ready to deploy' => {'Deployed to test' => 'Qa approved'},
                             'Reject' => {'Deployed to test' => 'Open'},
                             'Deploy to production' => {'Qa approved' => 'Deployed to production'},
                             'Close' => {'Deployed to production' => ''}
                            },
                        'Bug' => {'Start' => {'Open' => 'In progress'},
                                  'Done' => {'In progress' => 'Done'},
                                  'Deploy to test' => {'Done' => 'Deployed to test'},
                                  'Ready to deploy' => {'Deployed to test' => 'Qa approved'},
                                  'Reject' => {'Deployed to test' => 'Open'},
                                  'Deploy to production' => {'Qa approved' => 'Deployed to production'},
                                  'Close' => {'Deployed to production' => ''}
                        },
                        'Test case' => {'Pass' => {'Open' => 'Passed'},
                                        'Fail' => {'Open' => 'Failed'}}
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
    story_type = @project.story_types.find_or_create_by(title: story_type_title)
    states = states_for(story_type_title)
    status_map = {}
    states.each_with_index do |state, i|
      status = story_type.workflow_statuses.find_or_initialize_by(title: state)
      status.initial_status = i == 0
      status.save
      status_map[state] = status.id
    end

    @template[story_type_title].each do |event, transition_hash|
      transition = story_type.workflow_transitions.find_or_initialize_by(event: event)
      transition.from_status_id = status_map[transition_hash.keys.first]
      transition.to_status_id = status_map[transition_hash.values.first]
      transition.save
    end
  end

  def states_for(story_type)
    transitions = @template[story_type].values
    transitions.collect { |t| [t.keys + t.values] }.flatten.uniq.delete_if &:blank?
  end
end