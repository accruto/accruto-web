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

  context "scopes" do
    before(:each) do
      @candidate = create(:candidate)
      @candidate_happy_to_talk = create(:candidate, status: "Happy to talk")
      @candidate_no_work_visa = create(:candidate, visa: "No work visa")
      @candidate_minimum_annual_salary_150000 = create(:candidate, minimum_annual_salary: 150000)
      @candidate_updated_29_days_ago = create(:candidate_updated_29_days_ago)
    end
    it "returns jobs that matches searched job_title" do
      expect(Candidate.search_by_job_title("office")).to include(@candidate)
    end
    it "returns jobs that matches searched address" do
      expect(Candidate.filter_by_address("sydney")).to include(@candidate)
    end
    it "returns jobs that matches updated_at filter" do
      expect(Candidate.filter_by_updated_at("30")).to include(@candidate_updated_29_days_ago)
      expect(Candidate.filter_by_updated_at("3")).not_to include(@candidate_updated_29_days_ago)
    end
    it "returns jobs that matches status filter" do
      expect(Candidate.filter_by_status("Actively looking")).to include(@candidate)
    end
    it "does not return jobs that does not matches status filter" do
      expect(Candidate.filter_by_status("Actively looking")).not_to include(@candidate_happy_to_talk)
    end
    it "returns jobs that matches visa filter" do
      expect(Candidate.filter_by_visa("Valid work visa")).to include(@candidate)
    end
    it "does not return jobs that does not matches visa filter" do
      expect(Candidate.filter_by_visa("Valid work visa")).not_to include(@candidate_no_work_visa)
    end
    it "returns jobs that matches minimum_annual_salary filter (70,000 to 150,000)" do
      expect(Candidate.filter_by_minimum_annual_salary("70000","150000")).to include(@candidate)
    end
    it "does not return jobs that does not matches minimum_annual_salary filter (70,000 to 150,000)" do
      expect(Candidate.filter_by_minimum_annual_salary("40000","80000")).not_to include(@candidate_minimum_annual_salary_150000)
    end
    it "returns jobs that is sorted by updated_at"
  end

end
