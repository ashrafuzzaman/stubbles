class Task < ActiveRecord::Base
	include TaskPermission
  include Workflow

  belongs_to :story
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many   :time_entries, :as => :trackable

  scope :assigned_to, lambda { |user| where(:assigned_to_id => user.id) }

  after_save :update_story_status

  workflow_column :status
  workflow do
    state :new do
      event :start, :transitions_to => :started
    end
    state :started do
      event :pause, :transitions_to => :paused
      event :finish, :transitions_to => :finished
    end
    state :paused do
      event :start, :transitions_to => :started
    end
    state :finished
  end

  def total_hours_spent
    time_entries.sum('hours_spent')
  end

  def total_hours_spent_on(date)
    time_entries.spent_on(date).by(assigned_to).sum('hours_spent')
  end

  private
  def update_story_status
  	story.update_status
  end
end