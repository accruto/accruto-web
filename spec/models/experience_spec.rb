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

require 'spec_helper'

describe Experience do
  pending "add some examples to (or delete) #{__FILE__}"
end
