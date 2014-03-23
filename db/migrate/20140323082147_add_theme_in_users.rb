class AddThemeInUsers < ActiveRecord::Migration
  def change
    add_column :users, :theme, :string, default: 'dark_theme'
  end
end