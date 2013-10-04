class JobSubcategoriesCandidate < ActiveRecord::Base
  attr_accessible :candidate_id, :job_subcategory_id

  belongs_to :candidate
  belongs_to :job_subcategory

  validates :candidate_id, uniqueness: {scope: :job_subcategory_id}
end
