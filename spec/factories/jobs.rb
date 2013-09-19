require 'faker'

FactoryGirl.define do
  sequence :title do |n|
    "Office All Rounder #{n}"
  end

  factory :job do
  	association :company
  	association :address
  	title
  	description "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
  	tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
  	quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
  	consequat."
  	posted_at 1.day.ago
  	expires_at 1.day.from_now
  	external_job_id "123123"
  	source "CareerOne"
  	job_type { "Fulltime" }

  	factory :job_with_one_subcategory do
      title
  		after(:create) do |job|
  			job.subcategories << create(:job_category).subcategories[0]
  		end
  	end

    factory :job_with_two_subcategories do
      title
      after(:create) do |job|
        job.subcategories << create(:job_category).subcategories[0]
        job.subcategories << create(:job_category).subcategories[1]
      end
    end

  	factory :job_inactive do
      title
  		expires_at 1.day.ago
  		after(:create) do |job|
  			job.subcategories << create(:job_category).subcategories[0]
  			job.subcategories << create(:job_category).subcategories[1]
  		end
  	end

    factory :job_outside_sydney do
      title
      association :address, factory: :address_outside_sydney
    end

    factory :job_melbourne do
      title
      association :address, factory: :address_melbourne
    end

    factory :job_posted_1_day_ago do
      title
      posted_at 1.day.ago
    end

    factory :job_posted_7_days_ago do
      title
      posted_at 7.day.ago
    end

    factory :job_posted_29_days_ago do
      title
      posted_at 29.day.ago
    end

    factory :job_posted_30_days_ago do
      title
      posted_at 30.day.ago
    end
  end
end
