require 'faker'

FactoryGirl.define do
  factory :job do
  	title "Office All Rounder"
  	posted_at 1.day.ago
  	expires_at 1.day.from_now
  	company_id 1
  	address_id 1
  	external_link "http://jobview.careerone.com.au/GetJob.aspx?JobID=123977326&WT.mc_n=AFC_linkme"
  	job_type { "Fulltime" }
  end
end
