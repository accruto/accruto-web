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
		expect(create(:job_careerone)).to be_valid
	end

  it "has a company" do
		expect(create(:job).company).to be_valid
	end


  it "has an address" do
		expect(create(:job).address).to be_valid
	end

  it "has 2 subcategories" do
		expect(create(:job).subcategories.count).to eq(2)
	end

	context "is valid" do
		it "with a title, job_type, description, external_link, job_type, company_id, posted_at" do
			expect(build(:job)).to be_valid
		end
		it "with parsed XML" do
			expect(build(:job_careerone)).to be_valid
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

		it "without a posted_at" do
			expect(build(:job, posted_at: nil)).to have(1).errors_on(:posted_at)
		end

		it "without a company" do
			expect(build(:job, company: nil)).to have(1).errors_on(:company)
		end

		it "without a source" do
			expect(build(:job, source: nil)).to have(1).errors_on(:source)
		end
	end

	context "CareerOne Feed" do
		before(:each) do
			@response = Job.load_careerone_feed(1, 10)
		end

		context "Job Details" do
			it "returns an object of job details" do
				@response.each do |obj|
					expect(obj).to be_a_kind_of(OpenStruct)
				end
			end
			it "returns a title as a string" do
				@response.each do |obj|
					expect(obj.title).to be_a_kind_of(String)
				end
			end
			it "returns a posted_at as a DateTime" do
				@response.each do |obj|
					expect(obj.posted_at).to be_a_kind_of(DateTime)
				end
			end
			it "returns a expires_at as a DateTime" do
				@response.each do |obj|
					expect(obj.expires_at).to be_a_kind_of(DateTime)
				end
			end
			it "returns an array of types" do
				@response.each do |obj|
					expect(obj.types).to be_a_kind_of(Array)
				end
			end
			it "returns an array of industries" do
				@response.each do |obj|
					expect(obj.industries).to be_a_kind_of(Array)
				end
			end
			it "returns a description as a string" do
				@response.each do |obj|
					expect(obj.description).to be_a_kind_of(String)
				end
			end
		end

		context "Company Details" do
			it "returns an object of company details" do
				@response.each do |obj|
					expect(obj.company).to be_a_kind_of(OpenStruct)
				end
			end
			it "returns a name as string" do
				@response.each do |obj|
					expect(obj.company.name).to be_a_kind_of(String)
				end
			end
			it "returns a street as string" do
				@response.each do |obj|
					if obj.company.street
						expect(obj.company.street).to be_a_kind_of(String)
					else
						expect(obj.company.street).to eq(nil)
					end
				end
			end
			it "returns a city as string" do
				@response.each do |obj|
					expect(obj.company.city).to be_a_kind_of(String)
				end
			end
			it "returns a postcode as integer" do
				@response.each do |obj|
					if obj.company.postcode
						expect(obj.company.postcode).to be_a_kind_of(Integer)
					else
						expect(obj.company.postcode).to eq(nil)
					end
				end
			end
			it "returns a state as string" do
				@response.each do |obj|
					expect(obj.company.state).to be_a_kind_of(String)
				end
			end
		end
	end

end
