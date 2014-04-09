class RemoveRoleFromProjectMemberships < ActiveRecord::Migration
  def change
    remove_column :project_memberships, :role
  end
end
