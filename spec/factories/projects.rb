FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "Project ##{n}" }
    started_on { 1.month.ago.to_date }

    association :creator, factory: :user
  end
end
