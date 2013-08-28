class JobApplication < ActiveRecord::Base
  attr_accessible :accepted_terms, :email, :first_name, :job_id,
  								:last_name, :resume, :user_id, :cover_letter
  mount_uploader :resume, ResumeUploader
  belongs_to :job
  belongs_to :user
end
