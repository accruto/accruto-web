# == Schema Information
#
# Table name: jobs
#
#  id            :integer          not null, primary key
#  title         :string(255)
#  address_id    :integer
#  posted_at     :datetime
#  expires_at    :datetime
#  job_type      :string(255)
#  company_id    :integer
#  external_link :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe Job do
	it "has a valid factory" do
		expect(create(:job)).to be_valid
	end

  it "has a company" do
		expect(create(:job).company).to be_valid
	end

  it "has 2 subcategories" do
		expect(create(:job).subcategories.count).to eq(2)
	end

	it "is valid with a title, job_type, external_link, job_type, company_id, posted_at, expires_at" do
		expect(build(:job)).to be_valid
	end

	it "is invalid without a title" do
		expect(build(:job, title: nil)).to have(1).errors_on(:title)
	end

	it "is invalid with a title length > 70 characters" do
		expect(build(:job, title: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
		tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
		quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
		consequat.')).to have(1).errors_on(:title)
	end

	it "is invalid without an external_link" do
		expect(build(:job, external_link: nil)).to have(1).errors_on(:external_link)
	end

	it "is invalid without a job_type" do
		expect(build(:job, job_type: nil)).to have(1).errors_on(:job_type)
	end

	it "is invalid without a posted_at" do
		expect(build(:job, posted_at: nil)).to have(1).errors_on(:posted_at)
	end

	it "is invalid without an expires_at" do
		expect(build(:job, expires_at: nil)).to have(1).errors_on(:expires_at)
	end

	it "is invalid without a company" do
		expect(build(:job, company: nil)).to have(1).errors_on(:company)
	end

end
