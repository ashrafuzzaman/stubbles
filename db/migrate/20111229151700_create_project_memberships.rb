class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.references :project, :null => false
      t.references :user, :null => false
      t.string :role, :null => false
      t.boolean :active, :default => true
    end

    add_index :project_memberships, :user_id
    add_index :project_memberships, :project_id
  end
end