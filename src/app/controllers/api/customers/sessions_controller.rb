# frozen_string_literal: true

class Api::Customers::SessionsController < DeviseTokenAuth::SessionsController
  include Concerns::TokenAuthenticable
  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_api_customer!, only: :create
end
