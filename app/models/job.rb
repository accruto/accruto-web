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

 	pg_search_scope :search_jobs, against: [
 			[:title, 'A'],
	    [:description, 'B'],
 		],
 		associated_against: {
 			subcategories: :name
 		},
 	  using: { tsearch: {
 	  		dictionary: "simple"
 	  	}
 		}

  attr_accessible :company_id, :expires_at, :external_job_id, :source,
  								:posted_at, :title, :description, :job_type, :company_attributes,
  								:subcategories_attributes, :address_attributes, :subcategory_ids

 	validates_presence_of :title, :job_type, :description, :posted_at,
 												:company, :address, :source

 	validates :title, length: { maximum: 70 }
 	belongs_to :company
 	belongs_to :address

 	has_and_belongs_to_many :subcategories, class_name: "JobSubcategory"

 	accepts_nested_attributes_for :company
 	accepts_nested_attributes_for :subcategories
 	accepts_nested_attributes_for :address

 	scope :active, -> { where("expires_at > ?", DateTime.now) }

	def self.search_by_job_title(job_title)
		if job_title.present?
			search_jobs(job_title.downcase)
		else
			scoped
		end
	end

	def self.search_by_address(address)
		if address.present?
			joins(:address).merge(Address.where("to_tsvector('simple', street) @@ plainto_tsquery(:q) or to_tsvector('simple', city) @@ plainto_tsquery(:q) or to_tsvector('simple', state) @@ plainto_tsquery(:q)", q: address.to_s.downcase ))
		else
			scoped
		end
	end

	def self.filter_by_days(days)
		if days.present?
			where("posted_at >= ?", days.to_i.days.ago)
		else
			scoped
		end
	end

	def self.sort_by(option)
		if option.present?
			case option
			when 'posted_at'
				reorder("posted_at DESC")
			else
				scoped
			end
		else
			scoped
		end
	end

 	def self.load_careerone_feed(external_subcategory_id)
 		job_subcategory = JobSubcategory.where(external_subcategory_id: external_subcategory_id)
 		if job_subcategory.blank?
 			external_subcategory_id = 15432
 			external_category_id = 1
 		else
 			job_subcategory = job_subcategory.first
	 		external_category_id = job_subcategory.job_category.external_category_id
	 	end

 		cat = ENV['CAREERONE_CAT_CODE']
 		xml = open("http://jsx.monster.com/query.ashx?cy=au&pp=200&tm=0d&occ=#{external_category_id}.#{external_subcategory_id}&cat=#{cat}&rev=2.0")
 		parsed_xml = RecursiveOpenStruct.new(Hash.from_xml(xml))
 		@parsed_jobs = parsed_xml.Monster.Jobs.Job
 		jobs = []
 		unless @parsed_jobs.blank?
	 		@parsed_jobs.each do |parsed_job|
	 			parsed_job = RecursiveOpenStruct.new(parsed_job)
	 			job = OpenStruct.new
	 			job.company = OpenStruct.new

	 			job.title = parsed_job.Title
	 			job.external_job_id = parsed_job.ID
	 			job.source = 'CareerOne' # temporary
	 			job.posted_at = DateTime.strptime(parsed_job.DateActive, '%m/%d/%Y')
	 			job.expires_at = DateTime.strptime(parsed_job.DateExpires, '%m/%d/%Y')
	 			job.types = ['Full Time'] # temporary
	 			job.description = parsed_job.Summary

		 		job.industries = [] # temporary
		 		unless job_subcategory.blank?
	 				job.industries << job_subcategory.name
	 			else
	 				job.industries << "Others"
	 			end

	 			if parsed_job.CompanyName.blank?
	 				job.company.name = "The Advertiser"
	 			else
	 				job.company.name = parsed_job.CompanyName
	 			end
	 			job.city = parsed_job.Location.City
	 			job.state = parsed_job.Location.State
	 			job.postcode = parsed_job.Location.PostalCode

	 			jobs << job
	 		end
 			return jobs
 		end
 	end
end
