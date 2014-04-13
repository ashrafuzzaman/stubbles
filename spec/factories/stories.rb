FactoryGirl.define do
  factory :story do
    sequence(:title) { |n| "Story ##{n}" }
    description "MyText"
    project
    story_type { create(:story_type, project: project) }
    association :assigned_to, factory: :user
    start_at { Time.zone.now }

    ignore do
      number_of_tasks 0
    end

    after(:build) do |story, evaluator|
      story.tasks = FactoryGirl.build_list(:task, evaluator.number_of_tasks)
    end
  end
end
