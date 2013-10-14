class RegistrationsController < Devise::RegistrationsController
  def new
    @user = build_resource({})
    @user.build_candidate
    @invite = get_invite_details
    respond_with self.resource
  end

  def create
    build_resource(params[:user])
    if resource.save
      @invite = get_invite_details
      @invite.signed_up!
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def update
    super
  end

  def get_invite_details
    if session[:invite_email]
      return Invite.where(email: session[:invite_email]).first
    end
  end
end