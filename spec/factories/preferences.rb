# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :preference do
    user_id 1
    name "MyString"
    value "MyString"
  end
end
