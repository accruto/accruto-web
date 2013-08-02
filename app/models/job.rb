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

 	def self.load_careerone_feed(external_category_id, number_of_jobs)
 		cat = ENV['CAREERONE_CAT_CODE']
 		xml = open("http://jsx.monster.com/query.ashx?cy=au&pp=#{number_of_jobs}&tm=0d&jcat=#{external_category_id}&cat=#{cat}&rev=2.0")
 		xml = File.read(xml)
 		parsed_xml = RecursiveOpenStruct.new(Hash.from_xml(xml))
 		@parsed_jobs = parsed_xml.Monster.Jobs.Job
 		jobs = []
 		@parsed_jobs.each do |parsed_job|
 			parsed_job = RecursiveOpenStruct.new(parsed_job)
 			job = OpenStruct.new
 			job.company = OpenStruct.new

 			job.title = parsed_job.Title.downcase.split('-')[0].split('/')[0].split(' ').map { |w| w.capitalize }.join(' ')
 			job.external_job_id = parsed_job.ID
 			job.source = 'CareerOne' # temporary
 			job.posted_at = DateTime.strptime(parsed_job.DateActive, '%m/%d/%Y')
 			job.expires_at = DateTime.strptime(parsed_job.DateExpires, '%m/%d/%Y')
 			job.types = ['Full Time'] # temporary
 			job.description = parsed_job.Summary

 			job.categories = ["Accounting"] # temporary
 			job.industries = ["Mining"] # temporary

 			job.company.name = parsed_job.CompanyName
 			job.company.city = parsed_job.Location.City
 			job.company.state = parsed_job.Location.State
 			job.company.postcode = parsed_job.Location.PostalCode

 			jobs << job
 		end
 		return jobs
 	end
end
