class StoryType
  STORY = 'story'
  BUG = 'bug'
  ROUTINE = 'routine'
  TEST_CASE = 'test_case'

  def self.all
    [STORY, BUG, ROUTINE, TEST_CASE]
  end

  def self.all_selectable
    [[STORY.humanize, STORY],
     [BUG.humanize, BUG],
     [ROUTINE.humanize, ROUTINE],
     [TEST_CASE.humanize, TEST_CASE]]
  end
end