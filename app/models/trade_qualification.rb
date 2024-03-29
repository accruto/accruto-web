# == Schema Information
#
# Table name: trade_qualifications
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  attained_at  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  candidate_id :integer
#

class TradeQualification < ActiveRecord::Base
  attr_accessible :name, :attained_at, :candidate_id, :attained_at_text
  belongs_to :candidate

  YEARS = (1950..2016).to_a
  scope :sort_by_attained_at, -> { order("attained_at DESC") }

  def attained_at_text
    @attained_at || self.attained_at.try(:year)
  end

  def attained_at_text=(time)
    self.attained_at = Time.new(time.to_i) if time.present?
  end
end
