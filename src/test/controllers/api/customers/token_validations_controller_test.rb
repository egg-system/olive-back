require 'test_helper'
require_relative '../../../helpers/controllers/api/authorization_helper'

class ApiTokenValidationsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    customer = Customer.find(1)
    @auth_tokens = auth_tokens_for_user({ email: customer.email, password: 'test1234' })
    @auth_tokens = auth_tokens_for_user({ email: customer.email, password: 'test1234' })
  end

  test "validate token success" do
    get api_customers_validate_token_path, headers: @auth_tokens
    assert_response :success
  end

  test "validate token fail" do
    get api_customers_validate_token_path
    assert_response 401
  end
end
