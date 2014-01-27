require 'auditlog/model_tracker'

class Task < ActiveRecord::Base
  include Auditlog::ModelTracker
  track only: [:title, :status, :hours_estimated, :assigned_to_id], meta: [:project_id]
  attr_accessible :title, :hours_estimated, :assigned_to_id, :percent_completed

  include TaskPermission

  belongs_to :project, inverse_of: :tasks
  belongs_to :story, :touch => true, inverse_of: :tasks
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  belongs_to :workflow_status
  has_many :time_entries, :as => :trackable

  validates :title, :workflow_status_id, presence: true

  scope :assigned_to, lambda { |user| where(assigned_to_id: user.id) }
  scope :in_progress, lambda { where(status: 'in_progress') }
  scope :order_by_recent, -> { order 'created_at ASC' }
  default_scope { order_by_recent }

  before_create :set_project_id
  before_validation :set_initial_status
  after_save :propagate_hours_info_to_story
  after_destroy :propagate_hours_info_to_story

  ######################### Work flow ##########################
  #def allowable_workflow_transitions
  #  self.story.story_type.workflow_transitions.from_status(self.workflow_status_id)
  #end

  #======================== Work flow ==========================

  def time_entry_for(user, date)
    time_entries.spent_on(date).by(user).first
  end

  def total_hours_spent_on(date)
    time_entries.spent_on(date).by(assigned_to).sum('hours_spent')
  end

  def enter_time(user, date, hours_spent, percent_completed)
    time_entry = self.time_entries.spent_on(date).by(user).first_or_initialize
    time_entry.hours_spent = hours_spent
    time_entry.percent_completed = percent_completed
    time_entry.milestone_id = self.story.milestone_id
    time_entry.save!
    time_entry
  end

  private
  def propagate_hours_info_to_story
    story.hours_spent = story.tasks.sum(:hours_spent) if self.hours_spent_changed?
    story.hours_estimated = story.tasks.sum(:hours_estimated) if self.hours_estimated_changed?
    if hours_estimated_changed? or percent_completed_changed?
      story.percent_completed = story.recalculate_percent_completed
    end
    story.save! if story.changed?
  end

  def set_project_id
    self.project_id = self.story.project_id
  end

  def set_initial_status
    self.workflow_status ||= self.story.story_type.initial_workflow_status
  end
end