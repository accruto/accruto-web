# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  title           :string(255)
#  address_id      :integer
#  posted_at       :datetime
#  expires_at      :datetime
#  job_type        :string(255)
#  company_id      :integer
#  external_job_id :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  description     :text
#  source          :string(255)
#

require 'spec_helper'

describe Job do
	it "has a valid factory" do
		expect(create(:job)).to be_valid
	end

  it "has a company" do
		expect(create(:job).company).to be_valid
	end


  it "has an address" do
		expect(create(:job).address).to be_valid
	end

	context "scopes" do
		before(:each) do
			@job_active = create(:job)
			@job_inactive = create(:job_inactive)
			@job_posted_29_days_ago = create(:job_posted_29_days_ago)
		end

	  it "returns only active jobs" do
			expect(Job.active).to include(@job_active)
		end

	  it "does not return inactive jobs" do
			expect(Job.active).not_to include(@job_inactive)
		end

		it "returns jobs that matches searched job title" do
			expect(Job.search_by_job_title("office")).to include(@job_active)
		end
		it "returns jobs that matches searched address" do
			expect(Job.filter_by_address("sydney")).to include(@job_active)
		end
		it "returns jobs that matches days filter" do
			expect(Job.filter_by_days(30)).to include(@job_posted_29_days_ago)
			expect(Job.filter_by_days(3)).not_to include(@job_posted_29_days_ago)
		end
	end

	context "is valid" do
		it "with a title, job_type, description, external_link, job_type, company_id, posted_at" do
			expect(build(:job)).to be_valid
		end
	end

	context "is invalid" do
		it "without a title" do
			expect(build(:job, title: nil)).to have(1).errors_on(:title)
		end

		it "with a title length > 70 characters" do
			expect(build(:job, title: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
			tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
			quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
			consequat.')).to have(1).errors_on(:title)
		end

		it "without a description" do
			expect(build(:job, description: nil)).to have(1).errors_on(:description)
		end

		it "without a job_type" do
			expect(build(:job, job_type: nil)).to have(1).errors_on(:job_type)
		end

		it "without a company" do
			expect(build(:job, company: nil)).to have(1).errors_on(:company)
		end

		it "without a source" do
			expect(build(:job, source: nil)).to have(1).errors_on(:source)
		end
	end

end
