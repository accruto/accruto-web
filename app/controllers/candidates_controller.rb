class CandidatesController < ApplicationController
  before_filter :authenticate_user!, except: :search

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
    @user = current_user
    @candidate = @user.candidate
  end

  def edit
    @user = current_user
    @candidate = current_user.candidate
    @candidate.experiences.build
    @candidate.trade_qualifications.build
    @candidate.educations.build
    @candidate.subcategories.build
  end

  def create
    ##
  end

  def update
    if @candidate = current_user.candidate.update_attributes(params[:candidate])
      redirect_to show_profile_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_profile_path
    end
  end

  def publish
    current_user.candidate.publish!
    redirect_to show_profile_path, notice: 'Profile was successfully published.'
  end

  def unpublish
    current_user.candidate.unpublish!
    redirect_to show_profile_path, notice: 'Profile was successfully unpublished.'
  end
end