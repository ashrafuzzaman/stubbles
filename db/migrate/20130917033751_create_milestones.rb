class CreateMilestones < ActiveRecord::Migration
  def change
    create_table :milestones do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :delivered_at
      t.integer :duration
      t.string :milestone_type
      t.integer :project_id
      t.integer :parent_milestone_id

      t.timestamps
    end

    add_index :milestones, :project_id
    add_index :milestones, :parent_milestone_id
  end
end
