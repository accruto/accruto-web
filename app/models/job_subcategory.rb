class JobSubcategory < ActiveRecord::Base
  attr_accessible :job_category_id, :name, :category_attributes
  belongs_to :category, class_name: "JobCategory"
  has_and_belongs_to_many :jobs
  validates_presence_of :name

  accepts_nested_attributes_for :category
end
