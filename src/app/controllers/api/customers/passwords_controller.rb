class Api::Customers::PasswordsController < DeviseTokenAuth::PasswordsController
  include TokenAuthenticable

  skip_before_action :authenticate_staff!
  skip_before_action :authenticate_api_customer!
end
