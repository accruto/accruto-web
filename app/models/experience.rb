# == Schema Information
#
# Table name: experiences
#
#  id           :integer          not null, primary key
#  company      :string(255)
#  job_title    :string(255)
#  started_at   :datetime
#  ended_at     :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  current      :boolean
#  candidate_id :integer
#

class Experience < ActiveRecord::Base
  attr_accessible :company, :ended_at, :job_title, :started_at, :current, :candidate_id, :description
  belongs_to :candidate

  validates :job_title, uniqueness: {scope: :candidate_id}

  YEARS = (1800..2016).to_a
end
