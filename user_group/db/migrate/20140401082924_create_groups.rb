class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.integer :project_id
      t.integer :total_members

      t.timestamps
    end
  end
end
