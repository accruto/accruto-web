# == Schema Information
#
# Table name: trade_qualifications
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  year         :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  candidate_id :integer
#

class TradeQualification < ActiveRecord::Base
  attr_accessible :name, :year, :candidate_id
  belongs_to :candidate
end
