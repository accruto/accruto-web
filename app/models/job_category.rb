class JobCategory < ActiveRecord::Base
  attr_accessible :name
  has_many :subcategories, class_name: "JobSubcategory"
  validates_presence_of :name
end
