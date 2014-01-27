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

  def create_workflow
    #states = states_for(story_type)
    #status_map = {}
    #states.each { |state| status_map[state] = project.story_types.find_or_create_by(title: state).id }
    #
    #template.keys.each do |story_type_title|
    #  transitions = @template[story_type_title]
    #  project.story_types.find_or_create_by(title: state).id
    #
    #  transitions.each do |event, transition_hash|
    #    #event transition_hash
    #
    #  end
    #end
  end

  def states_for(story_type)
    transitions = @template[story_type].values
    transitions.collect { |t| [t.keys + t.values] }.flatten.uniq.delete_if &:blank?
  end
end