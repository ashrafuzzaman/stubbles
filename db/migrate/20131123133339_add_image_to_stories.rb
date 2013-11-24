class AddImageToStories < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.belongs_to :attachable, :polymorphic => true
      t.string :file, :null => false
      t.belongs_to :uploaded_by
      t.timestamps
    end
    add_index :attachments, [:attachable_type, :attachable_id]
  end
end
