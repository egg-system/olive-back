class ApplicationController < ActionController::Base
	before_action :authenticate_staff!
	protect_from_forgery with: :exception

	def after_sign_out_path_for(resource)
		new_staff_session_path
	end
end
