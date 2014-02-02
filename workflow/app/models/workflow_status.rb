class WorkflowStatus < ActiveRecord::Base
  belongs_to :project
  belongs_to :workflowable, polymorphic: true

  validates :title, :color, presence: true
  validate :at_least_one_initial_state
  attr_accessible :title, :description, :workflowable_type, :workflowable_id, :initial_status,
                  :color, :propagate_color_if_any, :propagate_color_if_all,
                  :allow_to_estimate, :allow_to_enter_time, :allow_to_delete

  scope :initials, -> { where(initial_status: true) }

  def transitions
    self.workflowable.workflow_transitions.from_status(self)
  end

  private
  def at_least_one_initial_state
    init_workflow_count = workflowable.workflow_statuses.where(initial_status: true).count
    init_workflow_count += 1 if (new_record? or initial_status_was == false) and initial_status?
    init_workflow_count -= 1 if persisted? and initial_status_was == true and initial_status == false

    errors.add(:initial_status, "There should only one initial status") if init_workflow_count > 1
  end
end