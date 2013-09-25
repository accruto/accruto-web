require 'spec_helper'

feature 'Candidate search' do
  context "As a recruiter, I should be able to search for a candidate by providing a job title" do
    scenario "job title exists in database" do
      @candidate = create(:candidate)
      visit root_path
      within(".main-search-candidates") do
        fill_in 'search_job_title', with: 'office'
        click_button 'Search'
      end
      expect(page).to have_content("There are 1 office candidates in Australia")
    end
    scenario "job title does not exist in database" do
      visit root_path
      within(".main-search-candidates") do
        fill_in 'search_job_title', with: 'office'
        click_button 'Search'
      end
      expect(page).to have_content("There are 0 office candidates in Australia")
    end
  end
  context "As a recruiter, I should be able to search for a job by providing an address" do
    scenario "address exists in database" do
      @candidate = create(:candidate)
      visit root_path
      within(".main-search-candidates") do
        fill_in 'search_address', with: 'sydney'
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.job_title)
    end
    scenario "address does not exist in database" do
      visit root_path
      within(".main-search-candidates") do
        fill_in 'search_address', with: 'sydney'
        click_button 'Search'
      end
      expect(page).not_to have_content('There are 1')
    end
  end

  context "As a recruiter, I should be able to refine my search results" do
    before(:each) do
      @candidate = create(:candidate)
      @candidate_no_work_visa = create(:candidate_no_work_visa, job_title: "Office All Rounder No work visa")
      @candidate_happy_to_talk = create(:candidate_happy_to_talk, job_title: "Office All Rounder Happy to talk")
      @candidate_updated_29_days_ago = create(:candidate_updated_29_days_ago)
      @candidate_updated_2_months_ago = create(:candidate_updated_2_months_ago)
      @candidate_melbourne = create(:candidate_melbourne)
      @candidate_cleaner = create(:candidate, job_title: "Cleaner")
      visit root_path
      within(".main-search-candidates") do
        fill_in 'search_job_title', with: 'office'
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.job_title)
    end
    scenario "search with new job title" do
      within(".sidebar-search-candidates") do
        fill_in 'search_job_title', with: @candidate_cleaner.job_title
        click_button 'Search'
      end
      expect(page).to have_content(@candidate_cleaner.job_title)
    end
    scenario "search with new address" do
      within(".sidebar-search-candidates") do
        fill_in 'search_address', with: @candidate_melbourne.address.city
        click_button 'Search'
      end
      expect(page).to have_content(@candidate_melbourne.job_title)
    end
    scenario "filter candidates updated_at the last 7 days" do
      within(".sidebar-search-candidates") do
        select('Last 7 days', :from => 'search_updated_at')
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.job_title)
      expect(page).not_to have_content("Updated 1 month ago")
      expect(page).not_to have_content("Updated 30 days ago")
      expect(page).not_to have_content("Updated 2 months ago")
    end
    scenario "filter candidates updated_at the last 30 days" do
      within(".sidebar-search-candidates") do
        select('Last 30 days', :from => 'search_updated_at')
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.job_title)
      expect(page).to have_content("Updated 29 days ago")
      expect(page).not_to have_content("Updated 2 months ago")
    end
    scenario "filter candidates updated_at the last 3 days" do
      within(".sidebar-search-candidates") do
        select('Last 3 days', :from => 'search_updated_at')
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.job_title)
      expect(page).not_to have_content("Updated 2 months ago")
    end
    scenario "filter candidates based on status" do
      within(".sidebar-search-candidates") do
        select('Actively looking', :from => 'search_status')
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.status)
      expect(page).not_to have_content(@candidate_happy_to_talk.job_title)
    end
    scenario "filter candidates based on visa" do
      within(".sidebar-search-candidates") do
        select('Valid work visa', :from => 'search_visa')
        click_button 'Search'
      end
      expect(page).to have_content(@candidate.visa)
      expect(page).not_to have_content(@candidate_no_work_visa.job_title)
    end
    scenario "filter candidates based on minimum_annual_salary"
    scenario "sort candidates by updated_at"
  end
end