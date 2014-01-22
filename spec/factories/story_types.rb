# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story_type do
    project nil
    title "MyString"
    description "MyText"
  end
end
