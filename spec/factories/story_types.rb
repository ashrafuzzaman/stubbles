# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story_type do
    project
    title "MyString"
    description "MyText"

    after(:build) do |story_type|
      build(:workflow_status, workflowable: story_type, initial_status: true)
      build_list(:workflow_status, 2, workflowable: story_type)
    end
  end
end
