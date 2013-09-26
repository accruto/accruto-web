# == Schema Information
#
# Table name: job_subcategories_jobs
#
#  id                 :integer          not null, primary key
#  job_subcategory_id :integer
#  job_id             :integer
#

class JobSubcategoriesJob < ActiveRecord::Base
  attr_accessible :job_id, :job_subcategory_id

  belongs_to :job
  belongs_to :job_subcategory
end
