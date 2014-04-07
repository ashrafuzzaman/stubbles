class WorkflowTransition < ActiveRecord::Base
  belongs_to :story_type
  belongs_to :from_status, class_name: 'WorkflowStatus'
  belongs_to :to_status, class_name: 'WorkflowStatus'

  validates :event, :from_status_id, :to_status_id, presence: true
  validates :to_status_id, uniqueness: {scope: :from_status_id}

  attr_accessible :event, :from_status_id, :to_status_id, :button_color, :actions
  serialize :actions, Array

  scope :from_status, -> (status) { where(from_status_id: status) }

  SUPPORTED_ACTIONS = [:progress_done, :restart_progress]

  def apply(resource)
    resource.update_attributes(workflow_status_id: self.to_status_id) if resource.workflow_status_id == self.from_status_id
    actions.each do |action|
      resource.send(action.to_sym) if resource.respond_to?(action.to_sym)
    end
  end
end