require 'spec_helper'

feature 'Job management' do
	before :each do
		@job = build(:job)
		@category = build(:job_category)
	end

	scenario 'admin creates a new job with valid fields' do
		visit new_job_path
		fill_in "Title", with: @job.title
		select_date @job.posted_at, :from => "job_posted_at"
		select_date @job.expires_at, :from => "job_expires_at"
		fill_in "External link", with: @job.external_link
		fill_in "Job type", with: @job.job_type

		fill_in "job_company_attributes_name", with: @job.company.name
		fill_in "job_company_attributes_phone", with: @job.company.phone

		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: @job.company.address.street
		fill_in "Postcode", with: @job.company.address.postcode
		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: @job.company.address.street
		fill_in "Postcode", with: @job.company.address.postcode

		fill_in "Subcategory name", match: :prefer_exact, with: @category.subcategories.name

		click_button "Create Job"
		expect(page).to have_content('Job was successfully created')
	end

	scenario 'admin fails to create a new job without a title' do
		visit new_job_path
		fill_in "Title", with: ""
		select_date @job.posted_at, :from => "job_posted_at"
		select_date @job.expires_at, :from => "job_expires_at"
		fill_in "External link", with: @job.external_link
		fill_in "Job type", with: @job.job_type

		fill_in "job_company_attributes_name", with: @job.company.name
		fill_in "job_company_attributes_phone", with: @job.company.phone

		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: @job.company.address.street
		fill_in "Postcode", with: @job.company.address.postcode
		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: @job.company.address.street
		fill_in "Postcode", with: @job.company.address.postcode

		fill_in "Subcategory name", match: :prefer_exact, with: @category.subcategories.name

		click_button "Create Job"
		expect(page).to have_content('Titlecan\'t be blank')
	end

	scenario 'admin fails to create a new job without an address street' do
		visit new_job_path
		fill_in "Title", with: @job.title
		select_date @job.posted_at, :from => "job_posted_at"
		select_date @job.expires_at, :from => "job_expires_at"
		fill_in "External link", with: @job.external_link
		fill_in "Job type", with: @job.job_type

		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: ""
		fill_in "Postcode", with: @job.company.address.postcode

		fill_in "Subcategory name", match: :prefer_exact, with: @category.subcategories.name

		fill_in "job_company_attributes_name", with: @job.company.name
		fill_in "job_company_attributes_phone", with: @job.company.phone
		click_button "Create Job"
		expect(page).to have_content('Streetcan\'t be blank')
	end

	scenario 'admin fails to create a new job without a subcategory' do
		visit new_job_path
		fill_in "Title", with: @job.title
		select_date @job.posted_at, :from => "job_posted_at"
		select_date @job.expires_at, :from => "job_expires_at"
		fill_in "External link", with: @job.external_link
		fill_in "Job type", with: @job.job_type

		fill_in "Unit", with: @job.company.address.unit
		fill_in "Street", with: @job.company.address.street
		fill_in "Postcode", with: @job.company.address.postcode

		fill_in "Subcategory name", with: ""

		fill_in "job_company_attributes_name", with: @job.company.name
		fill_in "job_company_attributes_phone", with: @job.company.phone
		click_button "Create Job"
		expect(page).to have_content('Subcategory namecan\'t be blank')
	end

	scenario 'admin updates a job with valid fields' do
		@created_job = create(:job)
		visit edit_job_path(@created_job)
		fill_in "Title", with: "Office Human Resource Manager"
		click_button "Update Job"
		expect(page).to have_content('Job was successfully updated')
	end

	scenario 'admin fails to update a job without an address street' do
		@created_job = create(:job)
		visit edit_job_path(@created_job)
		fill_in "Street", with: ""
		click_button "Update Job"
		expect(page).to have_content('Streetcan\'t be blank')
	end

	scenario 'admin deletes a job' do
		@created_job = create(:job)
		visit jobs_path
		click_link "Destroy"
		expect(page).to_not have_content(@created_job.title)
	end

	def select_by_id(id, options = {})
	  field = options[:from]
	  option_xpath = "//*[@id='#{field}']/option[#{id}]"
	  option_text = find(:xpath, option_xpath).text
	  select option_text, :from => field
	end

	def select_date(date, options = {})
	  field = options[:from]
	  select date.year.to_s,   :from => "#{field}_1i"
	  select_by_id date.month, :from => "#{field}_2i"
	  select date.day.to_s,    :from => "#{field}_3i"
	end
end