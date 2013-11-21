class TimeEntry < ActiveRecord::Base
  belongs_to :trackable, :polymorphic => true
  belongs_to :milestone
  belongs_to :user

  attr_accessible :spent_on, :hours_spent

  scope :spent_on, lambda { |date| where(:spent_on => date) }
  scope :before_date, lambda { |date| where("spent_on < ?", date) }
  scope :by, lambda { |user| where(:user_id => user) }
  default_scope order('spent_on ASC')

  validates :hours_spent, :numericality => true

  after_save :cache_time_spent_in_trackable, :update_trackable_percent_completed
  before_save :set_percent_completed_on_date

  private
  def cache_time_spent_in_trackable
    trackable.update_attribute :hours_spent, trackable.time_entries.sum('hours_spent') if hours_spent_changed?
  end

  def set_percent_completed_on_date
    if self.percent_completed_changed?
      last_time_entry = trackable.time_entries.before_date(spent_on).by(user).order('spent_on DESC').first
      self.percent_completed_on_date = [(percent_completed - last_time_entry.try(:percent_completed).to_f), 0].max
    end
  end

  def update_trackable_percent_completed
    if self.percent_completed_changed?
      trackable.update_attribute :percent_completed, trackable.time_entries(true).last.try(:percent_completed)
    end
  end
end