class WorkflowStatus < ActiveRecord::Base
  belongs_to :project
  belongs_to :workflowable, polymorphic: true

  #validates :title, :workflow_for, :project_id, presence: true
  attr_accessible :title, :description, :workflowable_type, :workflowable_id
end
