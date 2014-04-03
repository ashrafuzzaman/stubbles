class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :user_id
      t.integer :group_id
      t.timestamps
    end

    add_index :group_memberships, [:user_id, :group_id]
  end
end