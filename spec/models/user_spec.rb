# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  before :each do
    @user = create(:user)
    @user_admin = create(:user_admin)
    @invalid_user = build(:user_invalid)
    @job = create(:job)
  end

  context "valid user" do
    it "has a valid user admin" do
      expect(@user_admin).to be_valid
      expect(@user_admin.email).to eq("admin@example.com")
    end

    it "has a valid user signup" do
      expect(@user).to be_valid
      expect(@user.email).to eq("user@example.com")
    end

    it "has to be able to add favourite" do
      @user.favourites.build(:user_id => @user.id, :job_id => @job.id)
      @user.save
      expect(@user.favourite_jobs.first).to be_valid
      expect(@user.favourite_jobs.first.title).to include("Office All Rounder")
    end

    it "has to be able to remove favourite" do
      @user.favourites.build(:user_id => @user.id, :job_id => @job.id)
      @user.save
      expect(@user.favourite_jobs.size).to eq(1)
      @user.favourites.find_by_job_id(@job.id).delete
      expect(@user.favourite_jobs.size).to eq(0)
    end
  end

  context "invalid user" do
    it "has a invalid user data" do
      expect(@invalid_user).not_to be_valid
    end

    it "fails validation with invalid email (using errors_on)" do
      expect(@invalid_user).to have(1).errors_on(:email)
    end

    it "fails validation with invalid email expecting a specific message" do
      expect(@invalid_user.errors_on(:email)).to include("is invalid")
    end
  end
end
