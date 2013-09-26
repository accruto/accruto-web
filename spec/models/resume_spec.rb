# == Schema Information
#
# Table name: resumes
#
#  id                :integer          not null, primary key
#  candidate_id      :integer
#  courses           :text
#  awards            :text
#  skills            :text
#  objective         :text
#  summary           :text
#  other             :string(255)
#  citizenship       :string(255)
#  affiliations      :text
#  professional      :text
#  interests         :text
#  referees          :text
#  updated_at_linkme :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Resume do
  pending "add some examples to (or delete) #{__FILE__}"
end
