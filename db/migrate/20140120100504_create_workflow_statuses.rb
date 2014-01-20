class CreateWorkflowStatuses < ActiveRecord::Migration
  def change
    create_table :workflow_statuses do |t|
      t.string :title
      t.text :description
      t.string :workflow_for, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end