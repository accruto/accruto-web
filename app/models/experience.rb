# == Schema Information
#
# Table name: experiences
#
#  id         :integer          not null, primary key
#  company    :string(255)
#  job_title  :string(255)
#  started_at :datetime
#  ended_at   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Experience < ActiveRecord::Base
  attr_accessible :company_name, :ended_at, :job_title, :started_at
end
