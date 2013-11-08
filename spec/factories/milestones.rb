FactoryGirl.define do
  factory :milestone do
    sequence(:title) { |n| "Sprint ##{n}" }
    description "MyText"
    project
    start_on { Time.zone.now }
    end_on   { 7.days.from_now }
    delivered_on { 7.days.from_now }
    duration 5
    milestone_type Milestone::SPRINT_TYPE
  end
end
