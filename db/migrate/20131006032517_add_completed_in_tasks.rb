class AddCompletedInTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :percent_completed, :integer
    add_column :time_entries, :milestone_id, :integer
  end
end