class AddStatusToStories < ActiveRecord::Migration
  def change
    add_reference :stories, :workflow_status, index: true
  end
end
