class AddPercentCompletedInTimeEntries < ActiveRecord::Migration
  def change
    add_column :time_entries, :percent_completed, :integer
    add_column :time_entries, :percent_completed_on_date, :integer
  end
end
