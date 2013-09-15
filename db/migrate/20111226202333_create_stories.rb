class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :status
      t.string :story_type, :default => Scope::BACKLOG
      t.string :scope, :default => Scope::BACKLOG
      t.text :description
      t.references :project
      t.references :assigned_to
      t.integer :priority
      t.date :start_at
      t.date :complete_at
      t.date :deadline

      t.timestamps
    end
    add_index :stories, :project_id
    add_index :stories, :assigned_to_id
  end
end