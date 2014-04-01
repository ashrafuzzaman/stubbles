# This migration comes from user_group_engine (originally 20140401082941)
class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :user_id
      t.integer :user_group_id
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :group_memberships, [:user_id, :user_group_id]
  end
end
