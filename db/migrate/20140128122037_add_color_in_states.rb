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

    add_column :workflow_transitions, :button_color, :string
    add_column :story_types, :default_color, :string
  end
end