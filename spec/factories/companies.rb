# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
    "Shell Mobil #{n} Pty Ltd"
  end

  factory :company do
    name
    phone "02 9394 3994"
  end
end
