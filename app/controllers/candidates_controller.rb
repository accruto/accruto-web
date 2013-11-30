class CandidatesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @candidates = Candidate.published.paginate(page: params[:page], per_page: 10)
    @shortlists = current_user.shortlists.includes(:candidate)
  end

  def search
    @candidates = Candidate.scoped
                    .order('updated_at DESC')
                    .search_by_job_title(params[:search][:job_title])
                    .filter_by_address(params[:search][:address])
                    .filter_by_updated_at(params[:search][:updated_at])
                    .filter_by_status(params[:search][:status])
                    .filter_by_visa(params[:search][:visa])
                    .paginate(page: params[:page], per_page: 10)

    @shortlists = current_user.shortlists.includes(:candidate)
  end

  def show
    @user = current_user
    @candidate = @user.candidate
  end

  def edit
    @user = current_user
    @candidate = current_user.candidate
    @candidate = current_user.build_candidate if @candidate.nil?

    if session["profile_attributes"]
      @candidate = if current_user.candidate
        current_user.candidate.assign_attributes(session["profile_attributes"])
        current_user.candidate
      else
        current_user.build_candidate(session["profile_attributes"])
      end
    end

    @candidate.experiences.build if @candidate && @candidate.experiences.empty?
    @candidate.trade_qualifications.build if @candidate && @candidate.trade_qualifications.empty?
    @candidate.educations.build if @candidate && @candidate.educations.empty?
    @candidate.subcategories.build if @candidate && @candidate.subcategories.empty?
  end

  def create
    user = current_user

    if user.provider.presence && user.uid.presence
      redirect_to edit_profile_path
    end
  end

  def update
    session["profile_attributes"] = nil
    @candidate = current_user.candidate
    @candidate = current_user.build_candidate(params[:candidate]) if @candidate.nil?
    if @candidate.update_attributes(params[:candidate])
      redirect_to show_profile_path, notice: 'Profile was successfully updated.'
    else
      @candidate.experiences.build if @candidate.experiences.empty?
      @candidate.trade_qualifications.build if @candidate.trade_qualifications.empty?
      @candidate.educations.build if @candidate.educations.empty?
      @candidate.subcategories.build if @candidate && @candidate.subcategories.empty?
      render action: :edit
    end
  end

  def publish
    if !current_user.candidate.educations.empty? && !current_user.candidate.experiences.empty?
      current_user.candidate.publish!
      redirect_to show_profile_path, notice: "Congratulations. Your profile is now being submitted to potential employers.<br>In the meantime, <a href='#{new_invite_path}'>recommend your friends and receive #{Candidate::BOUNTY} for every friend that gets hired!</a>"
    else
      redirect_to edit_profile_path, alert: "You need to fill up your work experience and education details before you can submit your profile to employers."
    end
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

  def download_shortlisted_csv
    send_data Candidate.generate_csv_shortlist({host: request.host_with_port, recruiter: current_user}),
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: "attachment; filename=shortlisted_candidates.csv"
  end
end
