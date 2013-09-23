FactoryGirl.define do
  sequence :job_title do |n|
    "Office All Rounder #{n}"
  end

  factory :candidate do
    first_name "Test"
    last_name "Candidate"
    job_title
    phone "8888 8888"
    status "Actively Looking"
    visa "Valid work visa"
    minimum_annual_salary 50000
    association :address

    factory :candidate_outside_sydney do
      job_title
      association :address_outside_sydney
    end

    factory :candidate_melbourne do
      job_title
      association :address_melbourne
    end
  end
end