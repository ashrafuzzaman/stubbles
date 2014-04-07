class AddTransitionActionsInWorkflowTransitions < ActiveRecord::Migration
  def change
    add_column :workflow_transitions, :actions, :text
  end
end
