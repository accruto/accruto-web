require 'spec_helper'

describe Candidate do
  it "has a valid factory" do
    expect(create(:candidate)).to be_valid
  end

  it "has an address" do
    expect(create(:candidate).address).to be_valid
  end

  context "is valid" do
    it "with a first_name, job_title, last_name, phone, status, visa, minimum_annual_salary, address" do
      expect(build(:candidate)).to be_valid
    end
  end

  context "is invalid" do
    it "without a first_name" do
      expect(build(:candidate, first_name: nil)).to have(1).errors_on(:first_name)
    end

    it "without a last_name" do
      expect(build(:candidate, last_name: nil)).to have(1).errors_on(:last_name)
    end

    it "without a job_title" do
      expect(build(:candidate, job_title: nil)).to have(1).errors_on(:job_title)
    end

    it "without a status" do
      expect(build(:candidate, status: nil)).to have(1).errors_on(:status)
    end

    it "without a visa" do
      expect(build(:candidate, visa: nil)).to have(1).errors_on(:visa)
    end

    it "without a minimum_annual_salary" do
      expect(build(:candidate, minimum_annual_salary: nil)).to have(1).errors_on(:minimum_annual_salary)
    end
  end

end
