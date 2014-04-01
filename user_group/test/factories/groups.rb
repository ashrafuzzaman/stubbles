# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    title "MyString"
    description "MyText"
    project_id 1
    total_members 1
  end
end
