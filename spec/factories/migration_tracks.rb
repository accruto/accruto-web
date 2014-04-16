# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :migration_track do
    last_data_time "MyString"
    email "MyString"
  end
end
