# frozen_string_literal: true

module Concerns::TokenAuthenticable
  extend ActiveSupport::Concern

  included do
    include DeviseTokenAuth::Concerns::SetUserByToken
    before_action :authenticate_api_customer!
    protect_from_forgery with: :null_session

    def audited_user
      return current_api_customer if api_customer_signed_in?
    end
  end
end
