FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "First name #{n}" }
    sequence(:last_name) { |n| "Last name #{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    password '123456'
  end
end
