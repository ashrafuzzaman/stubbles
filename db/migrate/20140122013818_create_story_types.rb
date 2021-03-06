class CreateStoryTypes < ActiveRecord::Migration
  def up
    create_table :story_types do |t|
      t.references :project, index: true
      t.string :title
      t.text :description

      t.timestamps
    end

    remove_column :workflow_statuses, :workflow_for
    add_column :workflow_statuses, :workflowable_type, :string, index: true
    add_column :workflow_statuses, :workflowable_id, :integer, index: true

    remove_column :stories, :type
    add_column :stories, :story_type_id, :integer, index: true

    remove_column :tasks, :type
  end

  def down
    drop_table :story_types

    add_column :workflow_statuses, :workflow_for, :string
    remove_column :workflow_statuses, :workflowable_type
    remove_column :workflow_statuses, :workflowable_id

    add_column :stories, :type, :string
    add_column :stories, :story_type_id, :integer, index: true

    add_column :tasks, :type, :string
  end
end
