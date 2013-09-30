class MilestoneResource < ActiveRecord::Base
  attr_accessible :available_hours_per_day, :milestone_id, :resource_id

  belongs_to :milestone
  belongs_to :resource, :class_name => 'User'
end
