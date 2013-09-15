class StoryType
  STORY = 'story'
  BUG = 'bug'
  ROUTINE = 'routine'
  
  def self.all
    [STORY, BUG, ROUTINE]
  end
end