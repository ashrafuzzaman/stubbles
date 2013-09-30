class CreateMilestoneResources < ActiveRecord::Migration
  def change
    create_table :milestone_resources do |t|
      t.integer :milestone_id
      t.integer :resource_id
      t.float :available_hours_per_day

      t.timestamps
    end

    add_index :milestone_resources, :milestone_id
    add_index :milestone_resources, :resource_id
  end
end
