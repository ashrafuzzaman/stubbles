class CreateActivityTables < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.belongs_to :done_by
      t.string :name
      t.datetime :created_at
    end
    add_index :activities, :done_by_id

    create_table :versions do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.string :event, :null => false
      t.belongs_to :activity
      t.belongs_to :done_by
      t.belongs_to :project
      t.datetime :created_at
    end
    add_index :versions, [:trackable_type, :trackable_id]
    add_index :versions, :activity_id
    add_index :versions, :project_id

    create_table :version_changes do |t|
      t.belongs_to :version
      t.string :field, :null => false
      t.string :was
      t.string :now
    end
    add_index :version_changes, :version_id
  end

  # Drop table
  def self.down
    drop_table :version_changes
    drop_table :versions
    drop_table :activities
  end

  add_column :tasks, :project_id, :integer
  add_index :tasks, :project_id
end
