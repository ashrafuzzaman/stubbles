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

  def prev_chain
    current_status = self.id
    statuses = [current_status]
    transitions = workflowable.workflow_transitions.all
    transition_map = {}
    transitions.each do |transition|
      transition_map[transition.to_status_id] = transition.from_status_id
    end

    while true do
      current_status = transition_map[current_status]
      if current_status and !statuses.include?(current_status)
        statuses << current_status
      else
        break
      end
    end
    statuses.reverse
  end

  private
  def at_least_one_initial_state
    init_workflow_count = workflowable.workflow_statuses.where(initial_status: true).count
    init_workflow_count += 1 if (new_record? or initial_status_was == false) and initial_status?
    init_workflow_count -= 1 if persisted? and initial_status_was == true and initial_status == false

    errors.add(:initial_status, "There should only one initial status") if init_workflow_count > 1
  end
end