class CreateWorkflowTransitions < ActiveRecord::Migration
  def change
    create_table :workflow_transitions do |t|
      t.references :story_type, index: true
      t.string :event
      t.references :from_status, index: true
      t.references :to_status, index: true

      t.timestamps
    end
  end
end
