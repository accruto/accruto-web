require 'spec_helper'

feature 'Candidate search' do
  context "As a recruiter, I should be able to search for a candidate by providing a job title" do
    scenario "job title exists in database" do
      @job = create(:candidate)
      visit root_path
      within(".main-search-candidates") do
        fill_in 'job_title', with: 'office'
        click_button 'Search'
      end
      expect(page).to have_content("There are 1 office candidates in Australia")
    end
    scenario "job title does not exist in database" do
      visit root_path
      within(".main-search-candidates") do
        fill_in 'job_title', with: 'office'
        click_button 'Search'
      end
      expect(page).to have_content("There are 0 office candidates in Australia")
    end
  end
  context "As a recruiter, I should be able to search for a job by providing an address" do
    scenario "address exists in database"
    scenario "address does not exist in database"
  end

  context "As a recruiter, I should be able to refine my search results" do
    scenario "search with new job title"
    scenario "search with new address"
    scenario "filter candidates updated in the last 30 days"
    scenario "filter candidates updated in the last 3 days"
    scenario "filter candidates based on status"
    scenario "filter candidates based on visa"
    scenario "filter candidates based on minimum_annual_salary"
    scenario "sort candidates by updated_at"
  end
end