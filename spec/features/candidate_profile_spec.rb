require 'spec_helper'

feature 'Candidate profile' do
  context "As a candidate, I should be able to update my profile" do
    scenario "profile updated successfully with valid fields" do
      @candidate = create(:candidate)
      @user = @candidate.user
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Sign in'
      expect(page).to have_content(@user.email)
      visit edit_profile_path
      expect(page).to have_content('Edit Profile')
      fill_in 'First name', with: 'FirstName'
      fill_in 'Last name', with: 'LastName'
      fill_in 'Email', with: 'email@example.com'
      fill_in 'Phone', with: '0411888888'
      select('Immediately available', :from => 'Status')
      select('No work visa', :from => 'Visa')
      fill_in 'Job title', with: 'Product Manager'
      fill_in 'Minimum annual salary', with: '88888'
      click_button 'Update Profile'
      expect(page).to have_content('Profile was successfully updated.')
    end
  end
end
