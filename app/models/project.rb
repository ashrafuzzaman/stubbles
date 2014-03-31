class Project < ActiveRecord::Base
  attr_accessible :name, :creator, :description, :started_on, :sprint_length, :default_report_emails

  include ProjectPermission
  HOURS_PER_DAY = 8

  has_many :stories, inverse_of: :project, dependent: :destroy
  has_many :tasks, inverse_of: :project
  has_many :milestones, inverse_of: :project, dependent: :destroy
  has_many :memberships, :class_name => 'ProjectMembership', dependent: :destroy
  has_many :users, :through => :memberships, :source => :user
  has_many :story_types, dependent: :destroy
  belongs_to :creator, :class_name => 'User'

  validates :creator_id, presence: true
  validates :name, presence: true

  after_create :add_creator_as_project_admin, :create_default_workflow

  ########### Caching for the model ###########
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  #fetch is not working for some reason
  def cached_collaborators
    #Rails.cache.fetch([self, 'collaborators']) do
      self.collaborators.select(['users.id', 'users.first_name', 'users.last_name']).to_a
    #end
  end

  #fetch is not working for some reason
  def cached_milestones
    Rails.cache.fetch([self, 'milestones']) do
      self.milestones.active.select('milestones.id, milestones.title, milestones.project_id').to_a
    end
  end

  ########### Caching for the model ###########

  def collaborators
    self.users.where("(project_memberships.role = ? OR project_memberships.role = ?)
                        AND project_memberships.active = ?", Role::ADMIN, Role::MEMBER, true)
  end

  def membership_of(user)
    self.memberships.active.where(:user_id => user).first
  end

  def move_stories_to_milestone(milestone_id, story_ids)
    stories = self.stories.find(story_ids)
    stories.each do |story|
      story.update_attribute(:milestone_id, milestone_id)
    end
    stories
  end

  def copy_stories_to_milestone(milestone_id, story_ids)
    stories = self.stories.find(story_ids)
    cloned_stories = []
    stories.each do |story|
      cloned_story = story.dup
      cloned_story.milestone_id = milestone_id
      cloned_story.tasks = story.tasks.collect(&:dup)
      cloned_story.reset_status

      cloned_story.save
      cloned_stories << cloned_story
    end
    cloned_stories
  end

  def current_sprint
    self.milestones.current_sprints.first
  end

  private

  def add_creator_as_project_admin
    self.memberships.create(:user_id => creator.id, :role => Role::ADMIN)
  end

  def create_default_workflow
    WorkflowTemplate.new(self).create_workflow!
  end
end