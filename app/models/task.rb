require 'auditlog/model_tracker'

class Task < ActiveRecord::Base
  include Auditlog::ModelTracker
  track only: [:title, :status, :hours_estimated, :assigned_to_id], meta: [:project_id]
  attr_accessible :title, :hours_estimated, :assigned_to_id, :percent_completed

  include TaskPermission
  include Workflow

  belongs_to :project, inverse_of: :tasks
  belongs_to :story, :touch => true, inverse_of: :tasks
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  belongs_to :workflow_status
  has_many :time_entries, :as => :trackable

  scope :assigned_to, lambda { |user| where(assigned_to_id: user.id) }
  scope :in_progress, lambda { where(status: 'in_progress') }
  scope :order_by_recent, -> { order 'created_at ASC' }
  default_scope { order_by_recent }

  before_create :set_project_id
  after_save :update_story_status, :propagate_hours_info_to_story
  after_destroy :update_story_status, :propagate_hours_info_to_story

  #workflow_column :status
  #workflow do
  #  state :open do
  #    event :start, :transitions_to => :in_progress
  #  end
  #  state :in_progress do
  #    event :finish, :transitions_to => :finished
  #  end
  #  state :finished do
  #    event :qa_approve, :transitions_to => :qa_approved
  #    event :reopen, :transitions_to => :open
  #  end
  #  state :qa_approved do
  #    event :deploy, :transitions_to => :deployed
  #  end
  #  state :deployed do
  #    event :close, :transitions_to => :closed
  #    event :reopen, :transitions_to => :open
  #  end
  #  state :closed do
  #    event :reopen, :transitions_to => :open
  #  end
  #
  #  on_transition do |from, to, triggering_event, *event_args|
  #    self.touch
  #  end
  #end

  ######################### Work flow ##########################
  def allowable_workflow_transitions
    #self.story.story_type.workflow_transitions.from_status(self.work)
  end
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
  #not yet implemented
  def update_story_status
    story.update_status
  end

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

end