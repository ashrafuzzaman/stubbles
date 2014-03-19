require 'charter/line_chart'

class Milestone < ActiveRecord::Base
  attr_accessible :delivered_on, :description, :duration, :end_on, :start_on, :title, :milestone_type,
                  :parent_milestone_id, :milestone_resources_attributes, :generate_burn_down, :archived

  scope :sprints, -> { where(milestone_type: 'Sprint') }
  scope :active, -> { where(archived: false) }
  scope :current_sprints, -> { sprints.where('start_on <= :date AND end_on >= :date', date: Date.current).order('end_on ASC') }
  scope :long, -> { where('milestone_type <> ?', 'Sprint') }
  scope :without, ->(id) { where('milestones.id != ?', id) }
  scope :order_by_recent, order("end_on DESC")
  default_scope { order_by_recent }

  belongs_to :project, inverse_of: :milestones, touch: true
  has_many :stories, inverse_of: :milestone
  has_many :milestone_resources
  has_many :time_entries
  has_many :resources, through: :milestone_resources
  accepts_nested_attributes_for :milestone_resources, allow_destroy: true

  RELEASE_TYPE = 'Release'
  SPRINT_TYPE = 'Sprint'
  TYPES = [RELEASE_TYPE, SPRINT_TYPE]

  ########### Caching for the model ###########
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  ########### Caching for the model ###########

  def sprint?
    self.milestone_type == 'Sprint'
  end

  def tasks_assigned_to(user)
    story_ids = self.story_ids
    Task.assigned_to(user).where(story_id: story_ids)
  end

  def hours_assigned_to(user)
    tasks_assigned_to(user).sum(:hours_estimated)
  end

  #def hours_assigned
  #  self.stories.sum(:hours_estimated)
  #end
  #
  #def hours_spent
  #  self.stories.sum(:hours_spent)
  #end

  def hours_available_for(user)
    milestone_resource = milestone_resources.where(resource_id: user).first
    self.duration.to_f * milestone_resource.try(:available_hours_per_day).to_f
  end

  def burn_down_chart_data
    total_estimate = Task.where(story_id: self.story_ids).sum(:hours_estimated)
    estimated_hours_done_each_day = total_estimate / [(end_on - start_on).to_i + 1, 1].max
    burn_down_data = []
    total_spent = 0
    estimated_hours_remain = total_estimate.to_i
    end_date = [self.end_on, Date.current].min

    day = 0
    burn_down_data << {day: day, hours_remain: estimated_hours_remain, estimated_hours_remain: estimated_hours_remain}
    estimated_hours_remain -= estimated_hours_done_each_day

    hours_remain = 0

    start_on.upto(end_date) do |date|
      hours_spent = 0
      self.time_entries.spent_on(date).includes(:trackable).order('created_at DESC').each do |time_entry|
        hours_est = time_entry.trackable.hours_estimated
        hours_spent += (hours_est * time_entry.percent_completed_on_date.to_f)/100
      end

      total_spent += hours_spent
      hours_remain = total_estimate - total_spent
      day += 1
      burn_down_data << {day: day, hours_remain: hours_remain, estimated_hours_remain: [estimated_hours_remain, 0].max}
      estimated_hours_remain -= estimated_hours_done_each_day
    end

    (end_date + 1.day).upto(end_on) do |date|
      day += 1
      burn_down_data << {day: day, hours_remain: hours_remain, estimated_hours_remain: [estimated_hours_remain, 0].max}
      estimated_hours_remain -= estimated_hours_done_each_day
    end
    burn_down_data
  end

  def burn_down_chart
    chart = Charter::LineChart.new
    chart.data = self.burn_down_chart_data
    chart.columns = {hours_remain: 'Hours remaining', estimated_hours_remain: 'Estimated hours remaining'}
    chart.label_column = :day
    chart
  end

  def update_hour_calculations!
    self.hours_spent = self.stories.sum(:hours_spent)
    self.hours_estimated = self.stories.sum(:hours_estimated)
    self.percent_completed = self.recalculate_percent_completed
    self.save!
  end

  def assignment_status_for(resource)
    available_hr = hours_available_for(resource).to_i - hours_assigned_to(resource).to_i
    if available_hr > 0
      :available
    elsif available_hr < -10
      :busy
    elsif available_hr < 0
      :not_available
    else
      :filled
    end
  end

  def recalculate_percent_completed
    weighted_percent_completed = self.stories(true).inject(0) do |sum, story|
      sum + (story.percent_completed.to_f * story.hours_estimated.to_f)
    end
    weighted_percent_completed / [self.hours_estimated.to_f, 1].max
  end
end