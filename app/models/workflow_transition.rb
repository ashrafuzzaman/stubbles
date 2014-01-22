class WorkflowTransition < ActiveRecord::Base
  belongs_to :story_type
  belongs_to :from_status, class_name: 'WorkflowStatus'
  belongs_to :to_status, class_name: 'WorkflowStatus'

  attr_accessible :event, :from_status_id, :to_status_id
end