class RenameSomeColumns < ActiveRecord::Migration
  def change
    rename_column :workflow_statuses, :propagate_color_to_if_any, :propagate_color_if_any
    rename_column :workflow_statuses, :propagate_color_to_if_all, :propagate_color_if_all
  end
end
