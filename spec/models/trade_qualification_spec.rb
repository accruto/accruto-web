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

require 'spec_helper'

describe TradeQualification do
  pending "add some examples to (or delete) #{__FILE__}"
end
