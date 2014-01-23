class AddInitialStateToWorkflowStatuses < ActiveRecord::Migration
  def change
    add_column :workflow_statuses, :initial_status, :boolean
  end
end
