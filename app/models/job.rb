# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  address_id    :integer
#  posted_at     :datetime
#  expires_at    :datetime
#  job_type      :string(255)
#  company_id    :integer
#  external_job_id :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ActiveRecord::Base
  attr_accessible :company_id, :expires_at, :external_job_id,
  								:posted_at, :title, :description, :job_type, :company_attributes,
  								:subcategories_attributes, :address_attributes

 	validates_presence_of :title, :job_type, :description, :posted_at,
 												:expires_at, :company, :address

 	validates :title, length: { maximum: 70 }
 	belongs_to :company
 	has_one :address, as: :addressable

 	has_and_belongs_to_many :subcategories, class_name: "JobSubcategory"

 	accepts_nested_attributes_for :company
 	accepts_nested_attributes_for :subcategories
 	accepts_nested_attributes_for :address

 	def self.load_careerone_feed(number_of_jobs_to_load)
 		xml = File.read('careerone-feed.xml')
 		parsed_xml = RecursiveOpenStruct.new(Hash.from_xml(xml))
 		@parsed_jobs = parsed_xml.Envelope.Body.Body.QueriesResponse.Jobs.Job
 		jobs = []
 		@parsed_jobs.each do |parsed_job|
 			parsed_job = RecursiveOpenStruct.new(parsed_job)
 			job = OpenStruct.new
 			job.company = OpenStruct.new

 			# job details
 			job.title = parsed_job.JobInformation.JobTitle.downcase.split('-')[0].split('/')[0].split(' ').map { |w| w.capitalize }.join(' ')
 			job.external_job_id = parsed_job.jobRefCode
 			job.posted_at = DateTime.parse(parsed_job.JobPostings.JobPosting.JobPostingDates.JobPostDate)
 			job.expires_at = DateTime.parse(parsed_job.JobPostings.JobPosting.JobPostingDates.JobExpireDate)
 			job_types_parsed = parsed_job.JobInformation.JobStatus
 			job.types = [] # needs refactoring
 			if job_types_parsed.instance_of?(Array)
 				job_types_parsed.each do |job_type|
 					job.types << job_type
 				end
 			else
 				job.types << job_types_parsed
 			end
 			job.description = parsed_job.JobInformation.JobBody
 			job_categories_parsed = parsed_job.JobPostings.JobPosting.JobOccupations.JobOccupation
 			job.categories = [] # needs refactoring
 			if job_categories_parsed.instance_of?(Array)
 				job_categories_parsed.each do |category|
 					category = RecursiveOpenStruct.new(category)
 					job.categories << category.Name
 				end
 			else
 				job.categories << job_categories_parsed.Name
 			end
 			job_industries_parsed = parsed_job.JobPostings.JobPosting.Industries.Industry
 			job.industries = [] # needs refactoring
 			if job_industries_parsed.instance_of?(Array)
 				job_industries_parsed.each do |industry|
 					industry = RecursiveOpenStruct.new(industry)
 					job.industries << industry.IndustryName
 				end
 			else
 				job.industries << job_industries_parsed.IndustryName
 			end

 			# company details
 			job.company.name = parsed_job.JobInformation.Contact.CompanyName
 			job.company.street = parsed_job.JobPostings.JobPosting.PhysicalAddress.StreetAddress
 			job.company.city = parsed_job.JobPostings.JobPosting.PhysicalAddress.City
 			job.company.state = parsed_job.JobPostings.JobPosting.PhysicalAddress.State
 			job.company.postcode = parsed_job.JobPostings.JobPosting.PhysicalAddress.PostalCode.to_i unless parsed_job.JobPostings.JobPosting.PhysicalAddress.PostalCode.nil?

 			jobs << job
 		end
 		return jobs.take(number_of_jobs_to_load)
 	end
end
