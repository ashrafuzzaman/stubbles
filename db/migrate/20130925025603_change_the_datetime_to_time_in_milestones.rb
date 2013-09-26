class ChangeTheDatetimeToTimeInMilestones < ActiveRecord::Migration
  def up
    rename_column :milestones, :start_at, :start_on
    rename_column :milestones, :end_at, :end_on

    change_column :milestones, :start_on, :date
    change_column :milestones, :end_on, :date
  end

  def down
    rename_column :milestones, :start_on, :start_at
    rename_column :milestones, :end_on, :end_at

    change_column :milestones, :start_at, :datetime
    change_column :milestones, :end_at, :datetime
  end
end
