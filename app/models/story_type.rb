class StoryType < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  has_many :workflow_transitions
  has_many :workflow_statuses, as: :workflowable

  validates :title, :project_id, presence: true
  validates :title, uniqueness: {scope: :project_id}
  attr_accessible :title, :description

  def initial_workflow_status
    self.workflow_statuses.initials.first || self.workflow_statuses.first
  end
end