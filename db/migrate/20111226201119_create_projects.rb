class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.float :sprint_length, :default => 2
      t.date :started_on
      t.references :creator

      t.timestamps
    end
  end
end