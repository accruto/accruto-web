class ApplicationController < ActionController::Base
	protect_from_forgery

	rescue_from CanCan::AccessDenied do |exception|
	  redirect_to root_url, :alert => exception.message
	end

	def after_sign_in_path_for(resource)
		if current_user.has_role? :admin
			admin_jobs_path
		else
			root_path
		end
	end

	def after_sign_up_path_for(resource)
		root_path
	end

	def after_sign_out_path_for(resource)
		root_path
	end
end
