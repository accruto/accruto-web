# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :referral do
    name "MyString"
    email "MyString"
    message "MyText"
    token "MyString"
    referred_by_user_id 1
  end
end
