FactoryGirl.define do
  factory :candidate do
    association :address
    first_name "Test"
    last_name "Candidate"
    job_title "Office All Rounder"
    phone "8888 8888"
    status "Actively looking"
    visa "Valid work visa"
    minimum_annual_salary 80000

    factory :candidate_no_work_visa do
      job_title "Office All Rounder No Work Visa"
      visa "No work visa"
    end

    factory :candidate_happy_to_talk do
      job_title "Office All Rounder Happy To Talk"
      status "Happy to talk"
    end

    factory :candidate_outside_sydney do
      job_title "Office All Rounder Outside Sydney"
      association :address, factory: :address_outside_sydney
    end

    factory :candidate_melbourne do
      job_title "Office All Rounder Melbourne"
      association :address, factory: :address_melbourne
    end

    factory :candidate_cleaner do
      job_title "Cleaner"
    end

    factory :candidate_updated_29_days_ago do
      job_title "Office All Rounder Updated 29 days ago"
      updated_at 29.days.ago
    end

    factory :candidate_updated_2_months_ago do
      job_title "Office All Rounder Updated 2 months ago"
      updated_at 2.months.ago
    end
  end
end