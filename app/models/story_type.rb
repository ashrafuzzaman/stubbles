class StoryType < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  has_many :workflow_transitions
  has_many :workflow_statuses, as: :workflowable

  validates :title, :project_id, presence: true
  attr_accessible :title, :description
end