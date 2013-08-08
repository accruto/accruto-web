# == Schema Information
#
# Table name: job_categories
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  external_category_id :integer
#

class JobCategory < ActiveRecord::Base
  attr_accessible :name, :external_category_id
  has_many :subcategories, class_name: "JobSubcategory"
  validates_presence_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged
end
