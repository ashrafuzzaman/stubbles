FactoryGirl.define do
  factory :story do
    sequence(:title) { |n| "Story ##{n}" }
    description "MyText"
    project
    association :assigned_to, factory: :user
    start_at { Time.zone.now }
  end
end
