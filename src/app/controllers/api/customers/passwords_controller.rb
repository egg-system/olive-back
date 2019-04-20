class Api::Customers::PasswordsController < DeviseTokenAuth::PasswordsController
  include Concerns::TokenAuthenticable
  skip_before_action :authenticate_api_customer!
end