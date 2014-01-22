class StoryType < ActiveRecord::Base
  belongs_to :project
  has_many :stories

  validates :title, :project_id, presence: true
  attr_accessible :title, :description
end