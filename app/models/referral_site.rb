# == Schema Information
#
# Table name: referral_sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  token      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReferralSite < ActiveRecord::Base
  attr_accessible :name, :token

  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.token = SecureRandom.hex
    end while self.class.exists?(token: token)
  end
end
