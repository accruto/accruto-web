class CandidatesController < ApplicationController

  def search
    @candidates = Candidate.scoped
                    .order('updated_at DESC')
                    .search_by_job_title(params[:search][:job_title])
                    .filter_by_address(params[:search][:address])
                    .filter_by_updated_at(params[:search][:updated_at])
                    .filter_by_status(params[:search][:status])
                    .filter_by_visa(params[:search][:visa])
                    .paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(current_user.id)
    @candidate = @user.candidate
  end

  def edit
    @user = User.find(current_user.id)
    load_profile
  end

  def create
    ##
  end

  def update
    @profile = Profile.new(params[:profile])
    if @profile.save(current_user)
      redirect_to show_profile_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_profile_path
    end
  end

  def load_profile
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
        profile_photo: @candidate.profile_photo,
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