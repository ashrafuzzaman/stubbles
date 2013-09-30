class Milestone < ActiveRecord::Base
  attr_accessible :delivered_on, :description, :duration, :end_on, :start_on, :title, :milestone_type, :parent_milestone_id

  scope :sprints, -> { where(milestone_type: 'Sprint') }
  scope :long, -> { where('milestone_type <> ?', 'Sprint') }
  scope :without, ->(id) { where('milestones.id != ?', id) }

  belongs_to :project
  has_many :stories
  TYPES = ['Release', 'Sprint']

  def sprint?
    self.milestone_type == 'Sprint'
  end
end
