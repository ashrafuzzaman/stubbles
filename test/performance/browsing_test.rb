require 'test_helper'
require 'rails/performance_test_help'

class BrowsingTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory]
  #                          :output => 'tmp/performance', :formats => [:flat] }

  def test_homepage
    milestone = FactoryGirl.create(:milestone)
    story = FactoryGirl.create(:story, milestone: milestone, number_of_tasks: 5)
    ap story.tasks

    get "/projects/#{milestone.id}/dashboard"
  end
end
