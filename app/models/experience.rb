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
  attr_accessible :company, :ended_at, :job_title, :started_at, :current, :candidate_id, :description, :started_at_text, :ended_at_text
  belongs_to :candidate

  validates :job_title, uniqueness: {scope: :candidate_id}

  YEARS = (1800..2016).to_a

  scope :sort_by_ended_at, -> { order("ended_at DESC") }

  def started_at_text
    @started_at || self.started_at.try(:year)
  end

  def ended_at_text
    @ended_at || self.ended_at.try(:year)
  end

  def started_at_text=(time)
    self.started_at = Time.new(time.to_i) if time.present?
  end

  def ended_at_text=(time)
    self.ended_at = Time.new(time.to_i) if time.present?
  end
end
