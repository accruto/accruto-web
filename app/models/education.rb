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

class Education < ActiveRecord::Base
  attr_accessible :graduated_at, :institution, :qualification, :qualification_type, :candidate_id
  belongs_to :candidate

  YEARS = (1800..2016).to_a
  TYPES = %w(Doctorate Masters Degree Diploma Certificate School)
end
