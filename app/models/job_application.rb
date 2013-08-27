class JobApplication < ActiveRecord::Base
  attr_accessible :accepted_terms, :email, :first_name, :job_id,
  								:last_name, :resume, :user_id
  mount_uploader :resume, ResumeUploader
  has_one :job
  belongs_to :user
end
