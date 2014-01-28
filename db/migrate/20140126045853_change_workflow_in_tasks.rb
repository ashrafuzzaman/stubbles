class ChangeWorkflowInTasks < ActiveRecord::Migration
  def up
    add_column :tasks, :workflow_status_id, :integer
    remove_column :tasks, :status

    Project.scoped.each do |project|
      WorkflowTemplate.new(project).create_workflow!
    end
  end

  def down
    remove_column :tasks, :workflow_status_id
    add_column :tasks, :status, :string
  end
end