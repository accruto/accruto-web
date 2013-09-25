FactoryGirl.define do
  sequence :job_title do |n|
    "Office All Rounder #{n}"
  end

  factory :candidate do
    first_name "Test"
    last_name "Candidate"
    job_title
    phone "8888 8888"
    status "Actively looking"
    visa "Valid work visa"
    minimum_annual_salary 80000
    association :address

    factory :candidate_no_work_visa do
      visa "No work visa"
    end

    factory :candidate_happy_to_talk do
      status "Happy to talk"
    end

    factory :candidate_outside_sydney do
      job_title
      association :address, factory: :address_outside_sydney
    end

    factory :candidate_melbourne do
      job_title
      association :address, factory: :address_melbourne
    end

    factory :candidate_updated_29_days_ago do
      job_title
      updated_at 29.days.ago
    end

    factory :candidate_updated_2_months_ago do
      job_title
      updated_at 2.months.ago
    end
  end
end