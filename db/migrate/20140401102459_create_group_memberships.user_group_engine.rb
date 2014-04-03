# This migration comes from user_group_engine (originally 20140401082941)
class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :groups_users do |t|
      t.integer :user_id
      t.integer :group_id

      t.timestamps
    end
    add_index :groups_users, [:user_id, :group_id]
  end
end