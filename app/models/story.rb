class Story < ActiveRecord::Base
  attr_accessible :title, :assigned_to, :scope, :assigned_to_id, :description, :tag_list,
                  :story_type, :priority, :milestone_id

  include StoryPermission
  include Workflow
  acts_as_taggable

  validates :title, :presence => true
  validates :story_type, :presence => true

  belongs_to :project
  belongs_to :milestone
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  has_many :tasks, order: 'created_at ASC'
  has_many :comments, :as => :commentable

  default_scope :order => 'priority'
  scope :current, where(:scope => Scope::CURRENT)
  scope :backlog, where(:scope => Scope::BACKLOG)
  scope :yet_to_be_accepted, where(['stories.status != ?', 'accepted'])
  scope :assigned_to, lambda { |user| where(:assigned_to_id => user.id) }
  scope :assigned_to_task_for, lambda { |user| includes('tasks').where("tasks.assigned_to_id" => user.id) }
  scope :involved_with, lambda { |user_id| includes('tasks').where(["tasks.assigned_to_id = ? " + 
                                         "OR stories.assigned_to_id = ?", user_id, user_id]) }
  scope :attached_to_milestone, lambda { |milestone_id| where(milestone_id: milestone_id.present? ? milestone_id : nil) }

  before_create :autogenerate_priority
  before_create :assign_default_scope

  workflow_column :status
  workflow do
    state :not_started do
      event :start, :transitions_to => :started
    end
    state :started do
      event :finish, :transitions_to => :finished
    end
    state :finished do
      event :accept, :transitions_to => :accepted
      event :reject, :transitions_to => :rejected
      event :reopen, :transitions_to => :started
    end
    state :rejected do
      event :reopen, :transitions_to => :started
    end
    state :accepted
  end

  #TODO: add validation so that no user can be added that is not in the following list
  def assignable_users
    project.collaborators
  end

  def total_hours_estimated
    tasks.sum(:hours_estimated)
  end

  def total_hours_spent
    tasks.sum(:hours_spent)
  end

  def assigned?
    !self.assigned_to.nil?
  end

  def tasks_assigned_to(user)
    story.tasks.assigned_to(user)
  end

  def sealed_for_tasks?
  	['accepted', 'rejected'].include? status
  end

  def update_status
  	unless sealed_for_tasks?
  		start! if not_started? && any_task_started?
  		finish! if started?	&& all_tasks_finished?
  		reopen! if finished? && any_task_started?
  	end
  end

  def all_tasks_finished?
    tasks.each { |task| return false if !task.finished? }
    true
  end

  def any_task_started?
    tasks.each { |task| return true if task.started? }
    false
  end

  ######################### Priority ##########################
  def self.update_scope_and_priority(project, scope, story_to_shift_id, shift_from_story_id)
    #Story.display_table
    priority_to_assign = nil
    if(shift_from_story_id == 0) #means that adding as the last element of the scope
      priority_to_assign = (Story.highest_priority_by_scope(project, scope) || 0) + 1
      puts "Adding to last with priority of #{priority_to_assign}"
    else
      priority_to_assign = Story.find(shift_from_story_id).priority
      puts "Assigning priority with #{priority_to_assign}"
    end
    shift_priority_from(project, priority_to_assign)
    story = Story.find(story_to_shift_id)
    story.update_attributes({:scope => scope, :priority => priority_to_assign})
    #puts "After sort"
    #Story.display_table
  end

  def self.lowest_priority_by_scope(project, scope)
    project.stories.where('scope' => scope).minimum('priority')
  end

  def self.highest_priority_by_scope(project, scope)
    project.stories.where('scope' => scope).maximum('priority')
  end

  def self.shift_priority_from(project, priority, shift_by = 1)
    project.stories.update_all("priority = priority + #{shift_by}", ['priority >= ?', priority])
  end
  ######################### Priority ##########################

  private
  def autogenerate_priority
    lowest_priority_of_backlog = Story.lowest_priority_by_scope(project, Scope::BACKLOG)
    highest_priority_of_current = Story.highest_priority_by_scope(project, Scope::CURRENT)
    min_priority_in_scope = lowest_priority_of_backlog || (highest_priority_of_current || 0  + 1)
    Story.shift_priority_from(project, min_priority_in_scope)
    self.priority = min_priority_in_scope
  end

  def assign_default_scope
    self.scope = Scope::BACKLOG
  end

end