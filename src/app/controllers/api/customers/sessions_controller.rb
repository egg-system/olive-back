class Api::Customers::SessionsController < DeviseTokenAuth::SessionsController
  include Concerns::TokenAuthenticable
  skip_before_action :authenticate_api_customer!, only: :create
end
