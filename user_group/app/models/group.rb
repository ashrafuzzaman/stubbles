class Group < ActiveRecord::Base
  belongs_to :project
  attr_accessible :title, :description

  validates :title, presence: true, :uniqueness => {:scope => :project_id}
end