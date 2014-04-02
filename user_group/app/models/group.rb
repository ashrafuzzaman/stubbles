class Group < ActiveRecord::Base
  belongs_to :project
  attr_accessible :title, :description

  validates :title, presence: true, :uniqueness => {:scope => :project_id}

  def self.assign(project, user, group_ids)
    #user.groups = project.groups.find(group_ids)
  end
end