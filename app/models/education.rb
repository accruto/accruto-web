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
  attr_accessible :graduated_at, :institution, :qualification, :qualification_type, :qualification_major, :candidate_id,
                  :start_at, :graduated_at_text

  belongs_to :candidate
  validates :qualification, uniqueness: {scope: :candidate_id}

  YEARS = (1950..2016).to_a
  TYPES = %w(Doctorate Masters Degree Bachelor Diploma Certificate School Course)

  scope :sort_by_graduated_at, -> { order("graduated_at DESC") }

  def graduated_at_text
    @graduated_at || self.graduated_at.try(:year)
  end

  def graduated_at_text=(time)
    self.graduated_at = Time.new(time.to_i) if time.present?
  end
end
