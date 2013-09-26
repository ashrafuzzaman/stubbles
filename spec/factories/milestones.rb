# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :milestone do
    title "MyString"
    description "MyText"
    start_on "2013-09-17 09:37:51"
    end_on "2013-09-17 09:37:51"
    delivered_on "2013-09-17 09:37:51"
    duration 1
    type ""
  end
end
