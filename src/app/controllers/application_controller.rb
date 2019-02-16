class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :exception

	def after_sign_out_path_for(resource)
		new_user_session_path
	end
end
