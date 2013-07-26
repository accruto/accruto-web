# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  address_id    :integer
#  posted_at     :datetime
#  expires_at    :datetime
#  job_type          :string(255)
#  company_id    :integer
#  external_link :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Job < ActiveRecord::Base
  attr_accessible :address_id, :company_id, :expires_at, :external_link,
  								:posted_at, :title, :job_type

 	validates_presence_of :title, :external_link, :job_type, :address_id, :company_id,
 												:posted_at, :expires_at

 	validates :title, length: { maximum: 70 }
end
