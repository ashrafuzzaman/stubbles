FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task ##{n}" }
    story
    association :assigned_to, factory: :user
  end
end
