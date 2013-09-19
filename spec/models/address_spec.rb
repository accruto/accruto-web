# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street           :string(255)
#  city             :string(255)
#  postcode         :integer
#  state            :string(255)
#  latitude         :float
#  longitude        :float
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe Address do
  it "has a valid factory" do
		expect(create(:address)).to be_valid
	end

  it "is valid with a street, city, state, latitude, and longitude" do
		expect(build(:address)).to be_valid
	end

  it "is invalid without a city" do
		expect(build(:address, city: nil)).to have(1).errors_on(:city)
	end
end
