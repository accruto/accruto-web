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

  def edit_profile
    @user = User.find(current_user.id)
    unless @user.candidate
      @user.build_candidate
    end
  end

  def update_profile
    @user = User.find_or_initialize_by_id(current_user.id)
    if @user.update_attributes(params[:user], candidate_attributes: params[:user][:candidate_attributes])
      redirect_to edit_profile_path, notice: 'Profile was successfully updated.'
    else
      redirect_to edit_profile_path
    end
  end
end
