# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workflow_transition do
    event "MyString"
    from_status nil
    to_status nil
  end
end
