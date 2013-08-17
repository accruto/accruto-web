class UsersController < ApplicationController

  def preference
    @preference = Preference.find_or_initialize_by_user_id(current_user.id)
  end

  def update_preference
    @preference = Preference.find_or_initialize_by_user_id(current_user.id)
    @preference.update_attributes(params[:preference])

    redirect_to users_preference_url, notice: 'Preference was successfully updated.'
  end
end
