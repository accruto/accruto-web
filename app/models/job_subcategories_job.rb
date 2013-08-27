class JobSubcategoriesJob < ActiveRecord::Base
  attr_accessible :job_id, :job_subcategory_id

  belongs_to :job
  belongs_to :job_subcategory
end
