jitu = User.create(:email => 'ashrafuzzaman.g2@gmail.com', :first_name => 'A.K.M.', last_name: 'Ashrafuzzaman', :password => '123456')
setu = User.create(:email => 'zhd.zmn@gmail.com', :first_name => 'A.K.M.', last_name: 'Zahiduzzaman', :password => '123456')

stubbles = Project.create(:name => 'Stubbles', :creator => jitu, :description => 'Sample description', :started_on => 1.days.ago)
Project.create(:name => 'Newton freshair', :creator => setu, :description => 'Sample description', :started_on => 1.week.ago)

stubbles.memberships.create(:user => jitu, :role => Role::ADMIN)
stubbles.memberships.create(:user => setu, :role => Role::MEMBER)

stubbles.stories.create(:title => 'Story 1', :assigned_to => jitu)
stubbles.stories.create(:title => 'Story 2', :assigned_to => setu)
stubbles.stories.create(:title => 'Story 3', :assigned_to => setu, :scope => Scope::CURRENT)
stubbles.stories.create(:title => 'Story 4', :assigned_to => setu)