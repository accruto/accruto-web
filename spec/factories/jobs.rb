require 'faker'

FactoryGirl.define do
  factory :job do
  	association :company
  	title "Office All Rounder"
  	posted_at 1.day.ago
  	expires_at 1.day.from_now
  	external_link "http://jobview.careerone.com.au/GetJob.aspx?JobID=123977326&WT.mc_n=AFC_linkme"
  	job_type { "Fulltime" }
  	after(:create) do |job|
  		job.subcategories << create(:job_subcategory)
  		job.subcategories << create(:job_subcategory, name: "Mining")
  	end
  end
end
