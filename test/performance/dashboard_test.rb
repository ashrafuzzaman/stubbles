require 'test_helper'
require 'rails/performance_test_help'

class DashboardTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  self.profile_options = { :runs => 5, :metrics => [:wall_time, :memory], :formats => [:flat, :graph_html, :call_tree, :call_stack] }

  def test_homepage
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user, password: '123456')
    milestone = FactoryGirl.create(:milestone, project: project)
    FactoryGirl.create(:story, milestone: milestone, number_of_tasks: 5)
    post '/users/sign_in', :post => { :user => {email: user.email, password: '123456'} }
    get "/projects/#{milestone.id}/dashboard"
  end
end
