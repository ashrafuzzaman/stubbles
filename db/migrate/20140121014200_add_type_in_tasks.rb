class AddTypeInTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :type, :string, index: true
  end
end
