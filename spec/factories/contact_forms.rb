# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_form do
    full_name "MyString"
    email "MyString"
    about "MyString"
    message "MyString"
  end
end
