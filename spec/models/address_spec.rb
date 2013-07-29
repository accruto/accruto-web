# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  unit             :string(255)
#  street           :string(255)
#  postcode         :integer
#  latitude         :string(255)
#  longitude        :string(255)
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

  it "is valid with a unit, street, postcode, latitude, and longitude" do
		expect(build(:address)).to be_valid
	end

  it "is invalid without a unit" do
		expect(build(:address, unit: nil)).to have(1).errors_on(:unit)
	end

  it "is invalid without a street" do
		expect(build(:address, street: nil)).to have(1).errors_on(:street)
	end

  it "is invalid without a postcode" do
		expect(build(:address, postcode: nil)).to have(1).errors_on(:postcode)
	end
end
