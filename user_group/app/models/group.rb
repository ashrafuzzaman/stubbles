class Group < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :users

  attr_accessible :title, :description

  validates :title, presence: true, :uniqueness => {:scope => :project_id}
  scope :for_project, ->(project) { where(project_id: project) }

  def self.assign!(project, user, group_ids)
    user.groups = project.groups.find(group_ids)
  end
end