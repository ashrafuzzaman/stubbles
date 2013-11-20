class AddShortNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :short_name, :string
  end
end
