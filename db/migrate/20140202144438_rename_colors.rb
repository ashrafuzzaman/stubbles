class RenameColors < ActiveRecord::Migration
  def change
    rename_column :workflow_statuses, :default_color, :color
  end
end
