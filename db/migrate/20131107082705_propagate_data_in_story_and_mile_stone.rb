class PropagateDataInStoryAndMileStone < ActiveRecord::Migration
  def up
    add_column :stories, :hours_spent, :float
    add_column :stories, :hours_estimated, :float
    add_column :stories, :percent_completed, :integer

    add_column :milestones, :hours_spent, :float
    add_column :milestones, :hours_estimated, :float
    add_column :milestones, :percent_completed, :integer

    Story.scoped.find_in_batches do |group|
      group.each do |s|
        s.propagate_hours_spent
        s.propagate_hours_estimated
        s.reload.propagate_percent_completed
      end
    end
  end

  def down
    remove_column :stories, :hours_spent
    remove_column :stories, :hours_estimated
    remove_column :stories, :percent_completed

    remove_column :milestones, :hours_spent
    remove_column :milestones, :hours_estimated
    remove_column :milestones, :percent_completed
  end
end