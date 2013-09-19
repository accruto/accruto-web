# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    street "6, Belvoir Street"
    city "Sydney"
    postcode 2000
    state "NSW"
    latitude "23.2313"
    longitude "12.1231"

    factory :address_outside_sydney do
      street "11 Nicholson St"
      city "Melbourne"
      postcode 3053
      state "VIC"
      latitude "-37.803477"
      longitude "144.973891"
    end

    factory :address_melbourne do
      street "11 Nicholson St"
      city "Melbourne"
      postcode 3053
      state "VIC"
      latitude "-37.803477"
      longitude "144.973891"
    end
  end
end