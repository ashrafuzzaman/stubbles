jitu = User.create(:email => 'ashrafuzzaman.g2@gmail.com', :first_name => 'A.K.M.', last_name: 'Ashrafuzzaman', :password => '123456')
setu = User.create(:email => 'zhd.zmn@gmail.com', :first_name => 'A.K.M.', last_name: 'Zahiduzzaman', :password => '123456')
jhalak = User.create(:email => 'jhalak@tasawr.com', :first_name => 'Jhalak', last_name: 'Odikare', :password => '123456')

stubbles = Project.create(:name => 'Stubbles', :creator => jitu, :description => 'Sample description', :started_on => 1.days.ago)
Project.create(:name => 'Newton freshair', :creator => jhalak, :description => 'Sample description', :started_on => 1.week.ago)

stubbles.memberships.create(:user_id => jitu.id, :role => Role::ADMIN)
stubbles.memberships.create(:user_id => jhalak.id, :role => Role::MEMBER)

sprint = stubbles.milestones.create(title: 'Sprint #1', start_on: Date.current,
                                    end_on: 1.week.from_now.to_date, delivered_on: 1.week.from_now.to_date,
                                    milestone_type: Milestone::SPRINT_TYPE, duration: 5)
sprint.milestone_resources.create(available_hours_per_day: 6, milestone_id: sprint.id, resource_id: jitu.id)
sprint.milestone_resources.create(available_hours_per_day: 6, milestone_id: sprint.id, resource_id: jhalak.id)

stubbles.stories.create(:title => 'Story 1', :assigned_to => jitu, milestone_id: sprint.id)
stubbles.stories.create(:title => 'Story 2', :assigned_to => jitu, milestone_id: sprint.id)
stubbles.stories.create(:title => 'Story 3', :assigned_to => jhalak, milestone_id: sprint.id)
stubbles.stories.create(:title => 'Story 4', :assigned_to => jhalak)

