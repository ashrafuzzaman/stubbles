class Milestone < ActiveRecord::Base
  attr_accessible :delivered_on, :description, :duration, :end_on, :start_on, :title, :milestone_type,
                  :parent_milestone_id, :milestone_resources_attributes

  scope :sprints, -> { where(milestone_type: 'Sprint') }
  scope :long, -> { where('milestone_type <> ?', 'Sprint') }
  scope :without, ->(id) { where('milestones.id != ?', id) }

  belongs_to :project
  has_many :stories
  has_many :milestone_resources
  accepts_nested_attributes_for :milestone_resources, allow_destroy: true

  TYPES = ['Release', 'Sprint']

  def sprint?
    self.milestone_type == 'Sprint'
  end
end
