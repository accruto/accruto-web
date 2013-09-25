FactoryGirl.define do
  factory :job do
  	association :company
  	association :address
  	title "Office All Rounder"
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
      title "Office All Rounder One Subcategory"
  		after(:create) do |job|
  			job.subcategories << create(:job_category).subcategories[0]
  		end
  	end

    factory :job_with_two_subcategories do
      title "Office All Rounder Two Subcategories"
      after(:create) do |job|
        job.subcategories << create(:job_category).subcategories[0]
        job.subcategories << create(:job_category).subcategories[1]
      end
    end

  	factory :job_inactive do
      title "Office All Rounder Inactive"
  		expires_at 1.day.ago
  		after(:create) do |job|
  			job.subcategories << create(:job_category).subcategories[0]
  			job.subcategories << create(:job_category).subcategories[1]
  		end
  	end

    factory :job_outside_sydney do
      title "Office All Rounder Outside Sydney"
      association :address, factory: :address_outside_sydney
    end

    factory :job_melbourne do
      title "Office All Rounder Melbourne"
      association :address, factory: :address_melbourne
    end

    factory :job_posted_1_day_ago do
      title "Office All Rounder Posted 1 day ago"
      posted_at 1.day.ago
    end

    factory :job_posted_7_days_ago do
      title "Office All Rounder Posted 7 days ago"
      posted_at 7.day.ago
    end

    factory :job_posted_29_days_ago do
      title "Office All Rounder Posted 29 days ago"
      posted_at 29.day.ago
    end

    factory :job_posted_30_days_ago do
      title "Office All Rounder Posted 30 days ago"
      posted_at 30.day.ago
    end
  end
end
