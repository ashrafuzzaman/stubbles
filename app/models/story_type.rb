class StoryType
  FEATURE = 'Feature'
  BUG = 'Bug'
  ROUTINE = 'Routine'
  TEST_CASE = 'TestCase'

  def self.all
    [FEATURE, BUG, ROUTINE, TEST_CASE]
  end

  def self.all_selectable
    [[FEATURE.humanize, FEATURE],
     [BUG.humanize, BUG],
     [ROUTINE.humanize, ROUTINE],
     [TEST_CASE.humanize, TEST_CASE]]
  end
end