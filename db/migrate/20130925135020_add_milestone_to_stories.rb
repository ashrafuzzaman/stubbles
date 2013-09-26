class AddMilestoneToStories < ActiveRecord::Migration
  def change
    add_column :stories, :milestone_id, :integer
  end
end
