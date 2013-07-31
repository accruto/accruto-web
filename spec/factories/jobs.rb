require 'faker'

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
  	job_type { "Fulltime" }
  	after(:create) do |job|
  		job.subcategories << create(:job_subcategory)
  		job.subcategories << create(:job_subcategory, name: "Mining")
  	end

  	factory :job_careerone do
  		@job = Job.load_careerone_feed(1).first
  		title @job.title
  		description @job.description
  		posted_at @job.posted_at
  		expires_at @job.expires_at
  		external_job_id @job.external_job_id
  		job_type @job.types.join(", ")
  	end
  end
end
