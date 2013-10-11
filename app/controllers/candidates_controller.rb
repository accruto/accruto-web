class CandidatesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :search]

  def index
    @candidates = Candidate.paginate(page: params[:page], per_page: 10)
  end

  def search
    @candidates = Candidate.scoped
                    .order('updated_at DESC')
                    .search_by_job_title(params[:search][:job_title])
                    .filter_by_address(params[:search][:address])
                    .filter_by_updated_at(params[:search][:updated_at])
                    .filter_by_status(params[:search][:status])
                    .filter_by_visa(params[:search][:visa])
                    .published.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = current_user
    @candidate = @user.candidate
  end

  def edit
    @user = current_user
    @candidate = current_user.candidate
    @candidate.experiences.build if @candidate.experiences.empty?
    @candidate.trade_qualifications.build if @candidate.trade_qualifications.empty?
    @candidate.educations.build if @candidate.educations.empty?
    @candidate.subcategories.build
  end

  def create
    ##
  end

  def update
    @candidate = current_user.candidate
    if @candidate.update_attributes(params[:candidate])
      redirect_to show_profile_path, notice: 'Profile was successfully updated.'
    else
      render action: :edit
    end
  end

  def publish
    current_user.candidate.publish!
    redirect_to show_profile_path, notice: "Congratulations. Your profile was successfully submitted to potential employers.<br>In the meantime, <a href='#{new_invite_path}'>recommend your friends and receive #{Candidate::BOUNTY} for every friend that gets hired!</a>"
  end

  def unpublish
    current_user.candidate.unpublish!
    redirect_to show_profile_path, notice: 'Your profile has been withdrawn from potential employers.'
  end

  def search_job_categories
    job_subcategories = if params[:q].present?
      JobSubcategory.where("name ILIKE ?", "%#{params[:q]}%").map {|sc| [sc.id, sc.name]}
    else
      JobSubcategory.all.map {|sc| [sc.id, sc.name]}
    end

    results = []
    job_subcategories.each do |result|
      results << { id: result[1], text: result[1] }
    end

    compose_json = {
        more: false,
        results: results
    }

    respond_to do |format|
      format.json { render json: compose_json }
    end
  end
end
