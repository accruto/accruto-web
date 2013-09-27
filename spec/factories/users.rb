# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    password 'somepassword'
    password_confirmation 'somepassword'

    factory :member do
      after(:create) {|user| user.add_role(:member)}
    end
  end

  factory :user_invalid, class: User do
    email 'invaliduser'
    password 'somepassword'
    password_confirmation 'somepassword'
  end

  factory :user_admin, class: User do
    email 'admin@example.com'
    password 'somepassword'
    password_confirmation 'somepassword'

    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
