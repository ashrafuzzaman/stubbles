class AddColorInStates < ActiveRecord::Migration
  def change
    change_table :workflow_statuses do |t|
      t.string :default_color
      t.boolean :propagate_color_to_if_any
      t.boolean :propagate_color_to_if_all
      t.boolean :allow_to_estimate
      t.boolean :allow_to_enter_time
      t.boolean :allow_to_delete
    end
  end
end