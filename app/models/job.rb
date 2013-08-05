# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  address_id      :integer
#  posted_at       :datetime
#  expires_at      :datetime
#  job_type        :string(255)
#  company_id      :integer
#  external_job_id :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :text
#  source          :string(255)
#

class Job < ActiveRecord::Base
	require 'open-uri'
	include PgSearch
	# multisearchable :against => [:title, :description],
 	#  								using: {tsearch: {dictionary: "english"}}
 	pg_search_scope :search, against: [
 			[:title, 'A'],
	    [:description, 'B'],
 		],
 	  using: {tsearch: {dictionary: "simple"}}

  attr_accessible :company_id, :expires_at, :external_job_id, :source,
  								:posted_at, :title, :description, :job_type, :company_attributes,
  								:subcategories_attributes, :address_attributes

 	validates_presence_of :title, :job_type, :description, :posted_at,
 												:company, :address, :source

 	validates :title, length: { maximum: 70 }
 	belongs_to :company
 	has_one :address, as: :addressable

 	has_and_belongs_to_many :subcategories, class_name: "JobSubcategory"

 	accepts_nested_attributes_for :company
 	accepts_nested_attributes_for :subcategories
 	accepts_nested_attributes_for :address

 	scope :active, -> { where("expires_at > ?", DateTime.now) }

	def self.job_search(query)
		if query.present?
			search(query)
		else
			scoped
		end
	end

 	def self.load_careerone_feed(external_subcategory_id)
 		job_subcategory = JobSubcategory.where(external_subcategory_id: external_subcategory_id)
 		if job_subcategory.blank?
 			external_subcategory_id = 15432
 			job_category = OpenStruct.new
 			job_category.id = 1
 		else
	 		job_category = job_subcategory.first.job_category
	 		external_subcategory_id = job_subcategory.first.external_subcategory_id
	 	end

 		cat = ENV['CAREERONE_CAT_CODE']
 		xml = open("http://jsx.monster.com/query.ashx?cy=au&pp=200&tm=0d&occ=#{job_category.id}.#{external_subcategory_id}&cat=#{cat}&rev=2.0")
 		parsed_xml = RecursiveOpenStruct.new(Hash.from_xml(xml))
 		@parsed_jobs = parsed_xml.Monster.Jobs.Job
 		jobs = []
 		unless @parsed_jobs.blank?
	 		@parsed_jobs.each do |parsed_job|
	 			parsed_job = RecursiveOpenStruct.new(parsed_job)
	 			job = OpenStruct.new
	 			job.company = OpenStruct.new

	 			job.title = parsed_job.Title.downcase.split('-')[0].split('/')[0].split('(')[0].split('$')[0].split(' ').map { |w| w.capitalize }.join(' ')
	 			job.external_job_id = parsed_job.ID
	 			job.source = 'CareerOne' # temporary
	 			job.posted_at = DateTime.strptime(parsed_job.DateActive, '%m/%d/%Y')
	 			job.expires_at = DateTime.strptime(parsed_job.DateExpires, '%m/%d/%Y')
	 			job.types = ['Full Time'] # temporary
	 			job.description = parsed_job.Summary

		 		job.industries = [] # temporary
		 		unless job_subcategory.blank?
	 				job.industries << job_subcategory.first.name
	 			else
	 				job.industries << "Others"
	 			end

	 			if parsed_job.CompanyName.blank?
	 				job.company.name = "The Advertiser"
	 			else
	 				job.company.name = parsed_job.CompanyName
	 			end
	 			job.company.city = parsed_job.Location.City
	 			job.company.state = parsed_job.Location.State
	 			job.company.postcode = parsed_job.Location.PostalCode

	 			jobs << job
	 		end
 			return jobs
 		end
 	end
end
