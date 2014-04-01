class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :user_id
      t.integer :user_group_id
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
