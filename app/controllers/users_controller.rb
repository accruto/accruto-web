class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :download_csv]

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

  def csv; end

  def download_csv
    redirect_to users_csv_path, error: "You should select date range" and return unless params[:candidate][:range].present?

    candidate_range = params[:candidate][:range].split("-")
    start_date = Date.strptime(candidate_range[0].strip, "%m/%d/%Y")
    end_date = Date.strptime(candidate_range[1].strip, "%m/%d/%Y")
    limit = params[:candidate][:limit].present? ? params[:candidate][:limit] : nil
    positions = params[:candidate][:positions].split(",")

    send_data Candidate.generate_csv_report({
                                                host: request.host_with_port,
                                                start_date: start_date,
                                                end_date: end_date,
                                                limit: limit,
                                                positions: positions
                                            }),
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: "attachment; filename=candidates.csv"
  end
end
