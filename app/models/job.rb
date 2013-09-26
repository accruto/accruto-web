# == Schema Information
#
# Table name: jobs
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  address_id         :integer
#  posted_at          :datetime
#  expires_at         :datetime
#  job_type           :string(255)
#  company_id         :integer
#  external_job_id    :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  description        :text
#  source             :string(255)
#  slug               :string(255)
#  external_apply_url :string(255)
#  tsv                :tsvector
#

class Job < ActiveRecord::Base
	before_save :set_defaults

	require 'open-uri'
	include PgSearch

  attr_accessible :company_id, :expires_at, :external_job_id, :source,
  								:posted_at, :title, :description, :job_type, :company_attributes,
  								:subcategories_attributes, :address_attributes, :subcategory_ids, :address_id,
                  :created_at, :updated_at, :external_apply_url

  extend FriendlyId
  friendly_id :title, use: :slugged

 	validates_presence_of :title, :job_type, :description, :company, :address, :source
  validates :title, :uniqueness => {:scope => :external_job_id}, length: { maximum: 70 }

 	belongs_to :company
 	belongs_to :address

  has_many :job_subcategories_jobs
  has_many :subcategories, through: :job_subcategories_jobs, :source => :job_subcategory
  has_many :favourites
  has_many :favourite_users, through: :favourites, :source => :user
  has_many :applications, class_name: "JobApplication"

 	accepts_nested_attributes_for :company
 	accepts_nested_attributes_for :subcategories
 	accepts_nested_attributes_for :address

 	scope :active, -> { where("expires_at > ?", DateTime.now) }
  scope :search_by_job_title, lambda { |title_keyword| _title_has(title_keyword) if title_keyword.present? }
  scope :filter_by_address, lambda { |address| joins(:address).where("addresses.city @@ :q or addresses.state @@ :q", q: address.downcase) if address.present? }
  scope :filter_by_days, lambda { |days| where("posted_at >= ?", days.to_i.days.ago) if days.present? }

 	def set_defaults
 		self.posted_at = DateTime.now if self.posted_at.nil?
 		self.expires_at = 30.days.from_now if self.expires_at.nil?
 	end

	def self.sort_by(option)
		case option
		when 'posted_at'
			reorder("posted_at DESC")
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

  def self.grab_search_results(recent_search)
    unless recent_search.category
      search_results = Job.search_by_job_title(recent_search.job_title)
        .filter_by_address(recent_search.address)
        .filter_by_days(recent_search.days)
        .sort_by(recent_search.sort)
        .active
    else
      search_results = JobCategory.where(slug: recent_search.category)
        .first.subcategories.map { |sc| sc.jobs }
        .flatten
    end
    search_results
  end

  private

    pg_search_scope :_title_has, against: [
        [:title, 'A'],
        [:description, 'B']
    ], associated_against: {
        subcategories: :name
    }, using: {
        tsearch: {
          dictionary: "english",
          tsvector_column: 'tsv'
        }
    }
end
