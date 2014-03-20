class StoryType < ActiveRecord::Base
  belongs_to :project
  has_many :stories
  has_many :workflow_transitions
  has_many :workflow_statuses, as: :workflowable

  validates :title, :project_id, presence: true
  validates :title, uniqueness: {scope: :project_id}
  attr_accessible :title, :description, :default_color

  def initial_workflow_status
    self.workflow_statuses.initials.first || self.workflow_statuses.first
  end

  def estimable?
    @estimable ||= self.workflow_statuses.any? { |status| status.allow_to_estimate? }
  end

  def allow_to_enter_time?
    @allow_to_enter_time ||= self.workflow_statuses.any? { |status| status.allow_to_enter_time? }
  end
end