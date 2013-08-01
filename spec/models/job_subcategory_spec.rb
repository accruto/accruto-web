# == Schema Information
#
# Table name: job_subcategories
#
#  id                      :integer          not null, primary key
#  name                    :string(255)
#  job_category_id         :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  external_subcategory_id :integer
#

require 'spec_helper'

describe JobSubcategory do
  it "has a valid factory" do
		expect(create(:job_subcategory)).to be_valid
	end

	it "is valid with a name and external_subcategory_id" do
		expect(build(:job_subcategory)).to be_valid
	end

	it "is invalid without a name" do
		expect(build(:job_subcategory, name: nil)).to have(1).errors_on(:name)
	end
end
