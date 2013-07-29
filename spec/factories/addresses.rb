# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    unit "307"
    street "6, Belvoir Street"
    postcode 2010
    latitude "23.2313"
    longitude "12.1231"
  end
end
