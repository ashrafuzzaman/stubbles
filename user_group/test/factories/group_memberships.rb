# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_membership do
    user_id 1
    user_group_id 1
    active "MyString"
    boolean "MyString"
  end
end
