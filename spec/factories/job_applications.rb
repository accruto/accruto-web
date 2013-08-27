# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_application do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    resume "MyString"
    user_id 1
    job_id 1
    accepted_terms false
  end
end
