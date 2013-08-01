# == Schema Information
#
# Table name: job_categories
#
#  id                   :integer          not null, primary key
#  name                 :string(255)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  external_category_id :integer
#

require 'spec_helper'

describe JobCategory do
  it "has a valid factory" do
		expect(create(:job_category)).to be_valid
	end

  it "has 2 subcategories" do
		expect(create(:job_category).subcategories.count).to eq(2)
	end

	it "is valid with a name and external_category_id" do
		expect(build(:job_category)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:job_category, name: nil)).to have(1).errors_on(:name)
	end
end
