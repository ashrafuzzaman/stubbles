class AddLastAccessedInProjectMemberships < ActiveRecord::Migration
  def change
    add_column :project_memberships, :last_accessed_at, :datetime
  end
end
