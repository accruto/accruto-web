# == Schema Information
#
# Table name: educations
#
#  id            :integer          not null, primary key
#  instituition  :string(255)
#  qualification :string(255)
#  type          :string(255)
#  graduated_at  :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Education do
  pending "add some examples to (or delete) #{__FILE__}"
end
