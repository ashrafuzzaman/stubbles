# This migration comes from user_group_engine (originally 20140401082924)
class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.integer :project_id
      t.integer :total_members

      t.timestamps
    end

    add_index :groups, :project_id
  end
end
