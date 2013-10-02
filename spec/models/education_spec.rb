# == Schema Information
#
# Table name: educations
#
#  id                 :integer          not null, primary key
#  institution        :string(255)
#  qualification      :string(255)
#  qualification_type :string(255)
#  graduated_at       :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  candidate_id       :integer
#

require 'spec_helper'

describe Education do
  pending "add some examples to (or delete) #{__FILE__}"
end
