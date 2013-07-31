# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Company do
  it "has a valid factory" do
		expect(create(:company)).to be_valid
	end

	it "is valid with a name, phone and address" do
		expect(build(:company)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:company, name: nil)).to have(1).errors_on(:name)
	end
end
