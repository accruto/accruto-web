require 'spec_helper'

feature 'Job shortlist' do
  before :each do
    ## initialize data
    @user = create(:user)
    @job = create(:job)

    ## user login
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_on 'Sign in'
    expect(page).to have_content('Signed in successfully.')
  end

  context "user successfully" do
    scenario 'create favourite with valid data' do
      visit root_path
      fill_in 'job_title', with: 'office'
      fill_in 'address', with: 'sydney'
      click_button 'Search'
      expect(page).to have_content("There are 1 Office jobs in sydney")
      click_link "favourite-btn-#{@job.id}"
      ## TODO: ajax check result
    end
    scenario 'delete favourite with valid data'
  end

  context "user fails to" do
    scenario 'create favourite with invalid data'
    scenario 'delete favourite with invalid data'
  end

  def wait_for_ajax
    wait_until { page.evaluate_script("$.active") == 0 }
  end

  def wait_until
    require "timeout"
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end
end