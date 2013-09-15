class ChangeCommentsTextType < ActiveRecord::Migration
  def self.up
    change_table :comments do |t|
      t.change :text, :text
    end
  end

  def self.down
    change_table :comments do |t|
      t.change :text, :string
    end
  end
end
