class AddArchiveInMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :archived, :boolean, default: false
  end
end
