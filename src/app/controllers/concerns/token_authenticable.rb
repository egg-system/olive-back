module Concerns::TokenAuthenticable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_api_customer!
    skip_before_action :authenticate_staff!
    protect_from_forgery with: :null_session
  end
end