class OmniauthCallbacksController < ApplicationController

  def all
    auth = request.env["omniauth.auth"]

    if User.from_omniauth(auth)
      session["profile_attributes"] = {
        first_name: auth.info.first_name,
        last_name: auth.info.last_name,
        email: auth.info.email,
        profile_photo: auth.info.image,
        phone: auth.info.phone
      }
      redirect_to edit_profile_path
    end
  end

  def failure
    ## error raise here
  end

  alias_method :linkedin, :all
end