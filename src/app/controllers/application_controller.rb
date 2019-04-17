class ApplicationController < ActionController::Base
	before_action :authenticate_staff!, :set_host
	protect_from_forgery with: :exception

	def after_sign_out_path_for(resource)
		new_staff_session_path
	end

	def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end
end
