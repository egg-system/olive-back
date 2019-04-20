module Concerns::TokenAuthenticable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_api_customer!
    protect_from_forgery with: :null_session
  end
end