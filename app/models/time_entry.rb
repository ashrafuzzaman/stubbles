class TimeEntry < ActiveRecord::Base
  belongs_to :trackable, :polymorphic => true
  belongs_to :milestone

  scope :spent_on, lambda { |date| where(:spent_on => date) }
  scope :by, lambda { |user| where(:user_id => user.id) }

  validates :hours_spent, :numericality => true

  after_save :cach_time_spent_in_trackable

  private
  def cach_time_spent_in_trackable
  	trackable.hours_spent = trackable.time_entries.sum('hours_spent')
  	trackable.save
  end
end