class AddStIinStories < ActiveRecord::Migration
  def up
    change_column :stories, :story_type, :string, default: nil
    #Story.scoped.each do |story|
    #  story.story_type = case story.story_type
    #                       when 'story' then 'Feature'
    #                       when 'bug' then 'Bug'
    #                       when 'routing' then 'Routing'
    #                       else 'TestCase'
    #                     end
    #  story.save
    #end
    rename_column :stories, :story_type, :type
    remove_column :stories, :scope
  end

  def down
    rename_column :stories, :type, :story_type

    #Story.scoped.each do |story|
    #  story.story_type = case story.story_type
    #                       when 'Feature' then 'story'
    #                       when 'Bug' then 'bug'
    #                       when 'Routing' then 'routing'
    #                       else 'TestCase'
    #                     end
    #  story.save
    #end

    add_column :stories, :scope, :string
  end
end
