class Task < ActiveRecord::Base
  attr_accessible :title, :hours_estimated, :assigned_to_id, :percent_completed

  include TaskPermission
  include Workflow

  belongs_to :story
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :time_entries, :as => :trackable

  scope :assigned_to, lambda { |user| where(:assigned_to_id => user.id) }

  after_save :update_story_status

  workflow_column :status
  workflow do
    state :open do
      event :start, :transitions_to => :started
    end
    state :started do
      event :pause, :transitions_to => :paused
      event :finish, :transitions_to => :finished
    end
    state :paused do
      event :start, :transitions_to => :started
    end
    state :finished do
      event :qa_approve, :transitions_to => :qa_approved
    end
    state :qa_approved do
      event :deploy, :transitions_to => :deployed
    end
    state :deployed do
      event :close, :transitions_to => :closed
    end
    state :closed
  end

  def total_hours_spent
    time_entries.sum('hours_spent')
  end

  def total_hours_spent_on(date)
    time_entries.spent_on(date).by(assigned_to).sum('hours_spent')
  end

  def enter_time(user, date, hours_spent, percent_completed)
    time_entry = self.time_entries.spent_on(date).by(user).first_or_create
    time_entry.hours_spent = hours_spent
    time_entry.milestone_id = self.story.milestone_id
    self.update_attribute :percent_completed, percent_completed if percent_completed
    time_entry.save
    time_entry
  end

  private
  def update_story_status
    story.update_status
  end
end