require 'auditlog/model_tracker'

class Story < ActiveRecord::Base
  include Auditlog::ModelTracker
  track only: [:title, :assigned_to_id, :workflow_status_id], meta: [:project_id]

  attr_accessible :title, :assigned_to, :scope, :assigned_to_id, :description, :tag_list, :priority,
                  :milestone_id, :attachments_attributes, :story_type_id, :workflow_status_id

  include StoryPermission
  acts_as_taggable

  validates :title, :story_type_id, :presence => true
  validates :title, :uniqueness => {:scope => :milestone_id}

  belongs_to :project, :touch => true, inverse_of: :stories
  belongs_to :milestone, :touch => true, inverse_of: :stories
  belongs_to :assigned_to, :class_name => "User", :foreign_key => "assigned_to_id"
  belongs_to :story_type
  belongs_to :workflow_status
  has_many :tasks, inverse_of: :story
  has_many :comments, :as => :commentable
  has_many :attachments, :as => :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: proc { |attributes| attributes['file'].blank? }

  scope :order_by_priority, -> { order 'priority ASC' }
  default_scope { order_by_priority }

  scope :backlog, -> { where(milestone_id: nil) }
  scope :yet_to_be_accepted, -> { where(['stories.status != ?', 'accepted']) }
  scope :assigned_to, lambda { |user| where(:assigned_to_id => user.id) }
  scope :assigned_to_task_for, lambda { |user| includes('tasks').where("tasks.assigned_to_id" => user.id) }
  scope :involved_with, lambda { |user_id| includes('tasks').where(["tasks.assigned_to_id = ? " +
                                                                        "OR stories.assigned_to_id = ?", user_id, user_id]) }
  scope :attached_to_milestone, lambda { |milestone_id| where(milestone_id: milestone_id.present? ? milestone_id : nil) }

  before_create :auto_generate_priority
  after_save :propagate_hour_calculations_to_milestone
  before_save :reset_status_when_story_type_changed
  after_destroy :propagate_hour_calculations_to_milestone

  def self.search(q)
    joins('LEFT join milestones on(milestones.id = stories.milestone_id)').
        where('milestones.archived IS NULL OR milestones.archived = ?', false).
        where("stories.title ILIKE ? OR stories.id = ?", "%#{q}%", q.to_i)
  end

  #TODO: add validation so that no user can be added that is not in the following list
  def assignable_users
    project.collaborators
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

  def all_tasks_finished?
    tasks.each { |task| return false if !task.finished? }
    true
  end

  def any_task_started?
    tasks.each { |task| return true if task.in_progress? }
    false
  end

  def reset_status
    self.tasks.each do |task|
      task.workflow_status = nil
      task.set_initial_status

      task.hours_spent = 0
      task.percent_completed = 0
    end
    self.workflow_status_id = detect_current_status
  end

  ######################### Priority ##########################
  def self.update_scope_and_priority(project, story_to_shift_id, shift_from_story_id)
    priority_to_assign = nil
    if (shift_from_story_id == 0) #means that adding as the last element of the scope
      priority_to_assign = (Story.highest_priority_by_scope(project) || 0) + 1
    else
      priority_to_assign = Story.find(shift_from_story_id).priority
    end
    shift_priority_from(project, priority_to_assign)
    story = Story.find(story_to_shift_id)
    story.update_attributes(:priority => priority_to_assign)
  end

  def self.lowest_priority_by_scope(project)
    project.stories.minimum('priority')
  end

  def self.highest_priority_by_scope(project)
    project.stories.maximum('priority')
  end

  def self.shift_priority_from(project, priority, shift_by = 1)
    project.stories.update_all("priority = priority + #{shift_by}", ['priority >= ?', priority])
  end

  #======================== Priority ==========================

  def recalculate_percent_completed
    weighted_percent_completed = self.tasks(true).inject(0) do |sum, task|
      sum + (task.percent_completed.to_f * task.hours_estimated.to_f)
    end
    weighted_percent_completed / [self.hours_estimated.to_f, 1].max
  end

  def panel_color
    return ColorTheme::COLORS.first if new_record?
    statuses = self.tasks.collect(&:workflow_status).uniq
    #check any
    statuses.each do |status|
      return status.color if status.propagate_color_if_any?
    end

    #check all
    first_status = statuses.first
    return first_status.color if first_status and statuses.all? { |status| status.id == first_status.id and status.propagate_color_if_all? }
    self.story_type.default_color
  end

  def detect_current_status
    statuses = self.tasks.collect(&:workflow_status).uniq
    #check any
    statuses.each do |status|
      return status if status.propagate_color_if_any?
    end

    #check all
    status_chains = statuses.uniq.collect(&:prev_chain)
    return nil if status_chains.empty?

    status = nil
    catch (:done) do
      status_chains.first.each_with_index do |chain, i|
        current = status_chains.first[i]
        status_chains.each do |c|
          throw :done if c[i] != current
        end
        status = current
      end
    end
    status ? status : self.story_type.initial_workflow_status.try(:id)
  end

  def update_current_status
    self.update_attributes! workflow_status_id: detect_current_status
  end

  private
  def auto_generate_priority
    lowest_priority_of_backlog = Story.lowest_priority_by_scope(project)
    highest_priority_of_current = Story.highest_priority_by_scope(project)
    min_priority_in_scope = lowest_priority_of_backlog || (highest_priority_of_current || 0 + 1)
    Story.shift_priority_from(project, min_priority_in_scope)
    self.priority = min_priority_in_scope
  end

  def propagate_hour_calculations_to_milestone
    if milestone
      milestone.hours_spent = milestone.stories.sum(:hours_spent) if self.hours_spent_changed? or self.milestone_id_changed?
      milestone.hours_estimated = milestone.stories.sum(:hours_estimated) if self.hours_estimated_changed? or self.milestone_id_changed?
      if hours_estimated_changed? or percent_completed_changed? or self.milestone_id_changed?
        milestone.percent_completed = milestone.recalculate_percent_completed
      end
      milestone.save! if milestone.changed?
    end

    if self.milestone_id_changed?
      Milestone.find(self.milestone_id_was).update_hour_calculations! if self.milestone_id_was.to_i > 0
    end
  end

  def reset_status_when_story_type_changed
    reset_status if story_type_id_changed?
  end
end