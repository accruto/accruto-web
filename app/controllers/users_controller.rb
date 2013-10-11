class UsersController < ApplicationController
  before_filter :authenticate_user!, only: :index

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

  def index
    send_data Candidate.generate_csv_report(request.host_with_port),
              type: 'text/csv; charset=iso-8859-1; header=present',
              disposition: "attachment; filename=candidates.csv"
  end
end
