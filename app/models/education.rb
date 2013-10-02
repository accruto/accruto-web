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

class Education < ActiveRecord::Base
  attr_accessible :graduated_at, :instituition, :qualification, :type
end
