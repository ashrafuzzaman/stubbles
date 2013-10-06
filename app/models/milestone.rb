class Milestone < ActiveRecord::Base
  attr_accessible :delivered_on, :description, :duration, :end_on, :start_on, :title, :milestone_type,
                  :parent_milestone_id, :milestone_resources_attributes

  scope :sprints, -> { where(milestone_type: 'Sprint') }
  scope :current_sprints, -> { sprints.where('start_on <= :date AND end_on >= :date', date: Date.current).order('end_on ASC') }
  scope :long, -> { where('milestone_type <> ?', 'Sprint') }
  scope :without, ->(id) { where('milestones.id != ?', id) }

  belongs_to :project
  has_many :stories
  has_many :milestone_resources
  has_many :time_entries
  has_many :resources, through: :milestone_resources
  accepts_nested_attributes_for :milestone_resources, allow_destroy: true

  TYPES = ['Release', 'Sprint']

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

  def hours_available_for(user)
    milestone_resource = milestone_resources.where(resource_id: user).first
    self.duration * milestone_resource.try(:available_hours_per_day).to_f
  end

  def burn_down_chart_data
    total_estimate = Task.where(story_id: self.story_ids).sum(:hours_estimated)
    estimated_hours_done_each_day = total_estimate / [(end_on - start_on).to_i, 1].max
    burn_down_data = []
    total_spent = 0
    start_on.upto(end_on) do |date|
      hours_spent = self.time_entries.spent_on(date).sum(:hours_spent)
      total_spent += hours_spent
      hours_remain = total_estimate - total_spent
      burn_down_data << { date: date, hours_remain: hours_remain}
      #total_estimate -= estimated_hours_done_each_day
    end
    burn_down_data
  end
end