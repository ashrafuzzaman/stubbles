# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone_resource do
    milestone_id 1
    resource_id 1
    available_hours_per_day 1.5
  end
end
