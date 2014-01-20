class WorkflowStatus < ActiveRecord::Base
  belongs_to :project

  validates :title, :workflow_for, :project_id, presence: true
  attr_accessible :title, :description, :workflow_for
end
