# == Schema Information
#
# Table name: job_applications
#
#  id             :integer          not null, primary key
#  first_name     :string(255)
#  last_name      :string(255)
#  email          :string(255)
#  resume         :string(255)
#  user_id        :integer
#  job_id         :integer
#  accepted_terms :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  cover_letter   :text
#

class JobApplication < ActiveRecord::Base
  attr_accessible :accepted_terms, :email, :first_name, :job_id,
  								:last_name, :resume, :user_id, :cover_letter
  mount_uploader :resume, ResumeUploader
  belongs_to :job
  belongs_to :user
end
