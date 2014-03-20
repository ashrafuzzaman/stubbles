class AddEstimableInStoryTypes < ActiveRecord::Migration
  def change
    add_column :story_types, :estimable, :boolean, default: true
  end
end
