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
  attr_accessible :name, :attained_at, :candidate_id
  belongs_to :candidate

  YEARS = (1800..2016).to_a
end
