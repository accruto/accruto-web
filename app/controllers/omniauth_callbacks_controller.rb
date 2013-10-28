class OmniauthCallbacksController < ApplicationController

  def all
    auth = request.env["omniauth.auth"]

    if user = User.from_omniauth(auth)
      client = LinkedIn::Client.new(ENV["LINKEDIN_CONSUMER_KEY"], ENV["LINKEDIN_CONSUMER_SECRET"])
      client.authorize_from_access(user.linkedin_token, user.linkedin_secret)
      profile = client.profile(fields: [:educations, :positions, :certifications])

      session["profile_attributes"] = {
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        profile_photo: auth.info.image,
        phone: auth.info.phone,
        educations_attributes: prepare_educations_attributes(profile),
        experiences_attributes: prepare_experiences_attributes(profile),
        trade_qualifications_attributes: prepare_trade_qualifications_attributes(profile)
      }
      redirect_to edit_profile_path
    end
  end

  def failure
    ## error raise here
  end

  alias_method :linkedin, :all

  private

  def prepare_educations_attributes(profile)
    educations_attributes = {}
    profile.educations.all.each_with_index do |education, idx|
      educations_attributes[idx] = {
          'institution' => education.school_name,
          'qualification' => education.field_of_study,
          'qualification_type' => education.degree,
          'graduated_at_text' => education.end_date.year
      }
    end unless profile.educations.all.nil?
    educations_attributes
  end

  def prepare_experiences_attributes(profile)
    experiences_attributes = {}
    profile.positions.all.each_with_index do |position, idx|
      experiences_attributes[idx] = {
          'company' => position.try(:company).try(:name),
          'job_title' => position.title,
          'started_at_text' => position.start_date.try(:year),
          'ended_at_text' => position.end_date.try(:year),
      }
    end unless profile.positions.all.nil?
    experiences_attributes
  end

  def prepare_trade_qualifications_attributes(profile)
    trade_qualifications_attributes = {}
    profile.certifications.all.each_with_index do |certification, idx|
      trade_qualifications_attributes[idx] = {
          'name' => certification.name
      }
    end unless profile.certifications.all.nil?
    trade_qualifications_attributes
  end
end