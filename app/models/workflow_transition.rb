class WorkflowTransition < ActiveRecord::Base
  belongs_to :story_type
  belongs_to :from_status, class_name: 'WorkflowStatus'
  belongs_to :to_status, class_name: 'WorkflowStatus'

  validates :event, :from_status_id, :to_status_id, presence: true
  validates :to_status_id, uniqueness: {scope: :from_status_id}
  validates :event, uniqueness: {scope: :story_type_id}

  attr_accessible :event, :from_status_id, :to_status_id

  scope :from_status, -> (status) { where(from_status_id: status) }
end