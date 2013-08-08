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
#

class JobSubcategory < ActiveRecord::Base
  attr_accessible :job_category_id, :name, :category_attributes, :external_subcategory_id
  belongs_to :category, class_name: "JobCategory"
  has_and_belongs_to_many :jobs
  belongs_to :job_category
  validates_presence_of :name
  accepts_nested_attributes_for :category

  extend FriendlyId
  friendly_id :name, use: :slugged
end
