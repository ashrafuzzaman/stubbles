class StoryType < ActiveRecord::Base
  belongs_to :project

  validates :title, :project_id, presence: true
  attr_accessible :title, :description
end