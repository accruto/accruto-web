# == Schema Information
#
# Table name: job_subcategories
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  job_category_id         :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  external_subcategory_id :integer
#  slug                    :string(255)
#

class JobSubcategory < ActiveRecord::Base
  serialize :external_subcategory_ids, Array

  attr_accessible :job_category_id, :name, :category_attributes, :external_subcategory_id, :external_subcategory_ids
  belongs_to :category, class_name: "JobCategory", foreign_key: 'job_category_id'

  #has_and_belongs_to_many :jobs

  has_many :job_subcategories_jobs
  has_many :jobs, through: :job_subcategories_jobs

  belongs_to :job_category
  validates_presence_of :name
  accepts_nested_attributes_for :category

  extend FriendlyId
  friendly_id :name, use: :slugged
end
