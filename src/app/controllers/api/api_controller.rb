# frozen_string_literal: true

class Api::ApiController < ApplicationController
  skip_before_action :authenticate_staff!

  protected

  def render_response_ok
    render json: { "result": 'ok' }
  end

  def render_response_error(status_code = nil)
    case status_code
    when 401
      render status: :unauthorized, json: { "error": 'Unauthorized' }
    else
      render status: :internal_server_error, json: { "error": 'Internal Server Error' }
    end
  end
end
