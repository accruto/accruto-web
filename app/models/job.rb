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
#  external_link :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ActiveRecord::Base
  attr_accessible :company_id, :expires_at, :external_link,
  								:posted_at, :title, :job_type, :company_attributes, :subcategories_attributes

 	validates_presence_of :title, :external_link, :job_type, :posted_at,
 												:expires_at, :company

 	validates :title, length: { maximum: 70 }
 	#has_one :address, as: :addressable
 	belongs_to :company
 	has_and_belongs_to_many :subcategories, class_name: "JobSubcategory"

 	accepts_nested_attributes_for :company
 	accepts_nested_attributes_for :subcategories
end
