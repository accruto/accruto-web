class RegistrationsController < Devise::RegistrationsController
  def new
    @user = build_resource({})
    @user.build_candidate
    respond_with self.resource
  end

  def create
    build_resource(params[:user])
    if resource.save
      update_invite_signed_up
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

  def update_invite_signed_up
    if session[:invited_by]
      if @invited_by_user = User.where(email: session[:invited_by]).first
        @invite = Invite.where(email: resource.email, user_id: @invited_by_user.id).first
        if @invite
          @invite.signed_up!
        end
      end
    end
  end
end