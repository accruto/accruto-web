require 'spec_helper'

feature 'Job search' do
	before :each do
		@category = create(:job_category)
	end

	context "As a user, I should be able to search for a job by providing a job title" do
		scenario "job title exists in database" do
			@job = create(:job)
			visit root_path
			fill_in 'job_title', with: 'office'
			click_button 'Search'
			expect(page).to have_content("There are 1 office jobs in Australia")
		end
		scenario "job title does not exist in database" do
			visit root_path
			fill_in 'job_title', with: 'office'
			click_button 'Search'
			expect(page).to have_content("There are 0 office jobs in Australia")
		end
	end
	context "As a user, I should be able to search for a job by providing an address" do
		scenario "address exists in database" do
			@job = create(:job)
			visit root_path
			fill_in 'job_title', with: 'office'
			fill_in 'address', with: 'sydney'
			click_button 'Search'
			expect(page).to have_content("There are 1 office jobs in sydney")
		end
		scenario "address does not exist in database" do
			@job = create(:job_outside_sydney)
			visit root_path
			fill_in 'job_title', with: 'office'
			fill_in 'address', with: 'sydney'
			click_button 'Search'
			expect(page).to have_content("There are 0 office jobs in sydney")
		end
	end

	context "As a user, I should be able to refine my search results" do
		before(:each) do
			@job = create(:job)
			@job_posted_29_days_ago = create(:job_posted_29_days_ago)
			@job_melbourne = create(:job_melbourne)

			visit root_path
			fill_in 'job_title', with: 'office'
			fill_in 'address', with: 'sydney'
			click_button 'Search'
		end
		scenario "search with new job title" do
			fill_in 'job_title', with: 'office'
			click_button 'Search'
			expect(page).to have_content(@job_posted_29_days_ago.title)
		end
		scenario "search with new address" do
			fill_in 'address', with: 'melbourne'
			click_button 'Search'
			expect(page).to have_content(@job_melbourne.title)
		end
		scenario "filter jobs posted in the last 30 days" do
			select('Last 30 days', :from => 'days')
			click_button 'Search'
			expect(page).to have_content(@job_posted_29_days_ago.title)
		end
		scenario "filter jobs posted in the last 3 days" do
			select('Last 3 days', :from => 'days')
			click_button 'Search'
			expect(page).not_to have_content(@job_posted_29_days_ago.title)
		end
		scenario "sort jobs by date_posted" do
			select('Date Posted', :from => 'sort')
			click_button 'Search'
			result_container = find(".result-jobs")
			first_result = result_container.first(:css, 'li')
			expect(first_result).to have_content(@job.title)
		end
	end
end