class Api::ApiController < ApplicationController
	skip_before_action :authenticate_staff!

	protected
	def render_response_ok
		render json: { "result": "ok" }
	end

	def render_response_error(status_code = nil)
		case status_code
		when 401
			render status: 401, json: { "error": "Unauthorized" }
		else
			render status: 500, json: { "error": "Internal Server Error" }
		end
	end
end
