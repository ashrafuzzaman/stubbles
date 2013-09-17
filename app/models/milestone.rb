class Milestone < ActiveRecord::Base
  attr_accessible :delivered_at, :description, :duration, :end_at, :start_at, :title, :milestone_type, :parent_milestone_id

  scope :sprints, -> { where(milestone_type: 'Sprint') }
  scope :long, -> { where('milestone_type <> ?', 'Sprint') }
  scope :without, ->(id) { where('milestones.id != ?', id) }

  belongs_to :project

  def sprint?
    self.milestone_type == 'Sprint'
  end
end
