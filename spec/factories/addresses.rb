# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "6, Belvoir Street"
    city "Sydney"
    postcode 2000
    state "NSW"
    latitude "23.2313"
    longitude "12.1231"
  end
end
