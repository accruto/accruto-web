class UsersController < ApplicationController

  def preference
    @preference = Preference.find_or_initialize_by_user_id(current_user.id)
  end

  def update_preference
    @preference = Preference.find_or_initialize_by_user_id(current_user.id)
    @preference.update_attributes(params[:preference])

    redirect_to users_preference_url, notice: 'Preference was successfully updated.'
  end

  def applications
  	@job_applications = current_user.job_applications
  end

  def create_profile
  end

  # def edit_profile
  #   @user = User.find(current_user.id)
  #   unless @candidate = @user.candidate
  #     @candidate_form = @user.build_candidate
  #   end
  #   unless @resume = @candidate.resume
  #     @resume_form = @candidate.build_resume
  #   end
  # end

  def edit_profile
    @user = User.find(current_user.id)
    load_user_profile
  end

  def update_profile
    @profile = Profile.new(params[:profile])
    if @profile.save(current_user)
      redirect_to edit_profile_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_profile_path
    end
  end

  def load_user_profile
    if @candidate = current_user.candidate
      @experiences = @candidate.experiences.first
      @trade_qualifications = @candidate.trade_qualifications.first
      @educations = @candidate.educations.first
      #TODO : need to refactor this
      @profile = Profile.new(
        first_name: @candidate.first_name,
        last_name: @candidate.last_name,
        email: current_user.email,
        phone: @candidate.phone,
        summary: @candidate.summary,
        job_title: @candidate.job_title,
        status: @candidate.status,
        visa: @candidate.visa,
        minimum_annual_salary: @candidate.minimum_annual_salary,
        experience_company: @experiences.try(:company),
        experience_job_title: @experiences.try(:job_title),
        experience_started_at: @experiences.try(:started_at),
        experience_ended_at: @experiences.try(:ended_at),
        trade_qualification_name: @trade_qualifications.try(:name),
        trade_qualification_attained_at: @trade_qualifications.try(:attained_at),
        education_institution: @educations.try(:institution),
        education_qualification: @educations.try(:qualification),
        education_qualification_type: @educations.try(:qualification_type),
        education_graduated_at: @educations.try(:graduated_at),
      )
    else
      @profile = Profile.new(email: current_user.email)
    end
  end
end
