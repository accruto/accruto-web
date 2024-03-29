class ApplicationController < ActionController::Base
	protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_url, :alert => exception.message
	end

  before_filter :after_token_authentication
	after_filter :store_location

	def store_location
	 # store last url - this is needed for post-login redirect to whatever the user last visited.
	    if (request.fullpath != "/users/sign_in" && \
	        request.fullpath != "/users/sign_up" && \
	        request.fullpath != "/users/password" && \
	        !request.xhr?) # don't store ajax calls
	      session[:previous_url] = request.fullpath
	    end
	end

	def after_sign_in_path_for(resource)
		if current_user.has_role? :admin
			admin_root_path
		else
			edit_profile_path
		end
	end

	def after_sign_up_path_for(resource)
		create_profile_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end

	def after_inactive_sign_up_path_for(resource)
		create_profile_path
  end

  def after_token_authentication
    if params[:auth_token].present?
      user = User.find_by_authentication_token(params[:auth_token])
      if user && sign_in(:user, user)
        flash[:notice] = "You have successfully logged in"
      else
        root_path
      end
    end
  end

  def verify_admin
    unless current_user.has_role? :admin
      redirect_to root_path
    end
  end
end
