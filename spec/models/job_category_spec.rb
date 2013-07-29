require 'spec_helper'

describe JobCategory do
  it "has a valid factory" do
		expect(create(:job_category)).to be_valid
	end

  it "has 2 subcategories" do
		expect(create(:job_category).subcategories.count).to eq(2)
	end

	it "is valid with a name" do
		expect(build(:job_category)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:job_category, name: nil)).to have(1).errors_on(:name)
	end
end
