class AddGenerateBurndownChartInMilestones < ActiveRecord::Migration
  def change
    add_column :milestones, :generate_burn_down, :boolean
  end
end
