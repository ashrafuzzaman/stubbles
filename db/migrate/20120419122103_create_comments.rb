class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :user
      t.references :commentable, :polymorphic => {:default => 'Story'}

      t.timestamps
    end
    add_index :comments, :user_id
    add_index :comments, :commentable_id
  end
end
