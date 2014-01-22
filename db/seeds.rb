jitu = User.create!(:email => 'ashrafuzzaman.g2@gmail.com', :first_name => 'A.K.M.', last_name: 'Ashrafuzzaman', :password => '123456', short_name: 'Jitu')
setu = User.create!(:email => 'zhd.zmn@gmail.com', :first_name => 'A.K.M.', last_name: 'Zahiduzzaman', :password => '123456', short_name: 'Setu')
jhalak = User.create!(:email => 'jhalak@tasawr.com', :first_name => 'Jhalak', last_name: 'Odikare', :password => '123456', short_name: 'Jhalak')

stubbles = Project.create!(:name => 'Stubbles', :creator => jitu, :description => 'Sample description', :started_on => 1.days.ago)
Project.create!(:name => 'Newton freshair', :creator => jhalak, :description => 'Sample description', :started_on => 1.week.ago)

stubbles.memberships.create!(:user_id => jhalak.id, :role => Role::MEMBER)

sprint = stubbles.milestones.create!(title: 'Sprint #1', start_on: Date.current,
                                    end_on: 1.week.from_now.to_date, delivered_on: 1.week.from_now.to_date,
                                    milestone_type: Milestone::SPRINT_TYPE, duration: 5)
sprint.milestone_resources.create!(available_hours_per_day: 6, milestone_id: sprint.id, resource_id: jitu.id)
sprint.milestone_resources.create!(available_hours_per_day: 6, milestone_id: sprint.id, resource_id: jhalak.id)

s1 = stubbles.stories.create!(:title => 'Story 1', :assigned_to => jitu, milestone_id: sprint.id)
s1.tasks.create!(title: "Task 1", hours_estimated: 10, assigned_to_id: jitu.id)
s1.tasks.create!(title: "Task 2", hours_estimated: 20, assigned_to_id: jitu.id)

s2 = stubbles.stories.create!(:title => 'Story 2', :assigned_to => jitu, milestone_id: sprint.id)
s2.tasks.create!(title: "Task 3", hours_estimated: 5, assigned_to_id: jitu.id)
s2.tasks.create!(title: "Task 4", hours_estimated: 10, assigned_to_id: jitu.id)

s3 = stubbles.stories.create!(:title => 'Story 3', :assigned_to => jhalak, milestone_id: sprint.id)
s3.tasks.create!(title: "Task 5", hours_estimated: 5, assigned_to_id: jhalak.id)
s3.tasks.create!(title: "Task 6", hours_estimated: 10, assigned_to_id: jhalak.id)

s4 = stubbles.stories.create!(:title => 'Story 4', :assigned_to => jhalak)
s4.tasks.create!(title: "Task 7", hours_estimated: 10, assigned_to_id: jhalak.id)
s4.tasks.create!(title: "Task 8", hours_estimated: 12, assigned_to_id: jhalak.id)