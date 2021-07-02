require 'test_helper'

class ApiRegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @register_data = {
      first_name: Faker::Name.name,
      last_name: Faker::Name.name,
      first_kana: Faker::Name.name,
      last_kana: Faker::Name.name,
      tel: Faker::Number.number(digits: 11),
      zip_code: Faker::Address.zip_code,
      prefecture: Faker::Address.street_name,
      city: Faker::Address.city,
      first_visit_store_id: 1,
      last_visit_store_id: 1,
      can_receive_mail: 1,
      email: Faker::Internet.email,
      password: 'test123'
    }
  end

  test "should register customer" do
    post '/api/customers/', params: @register_data
    assert_response :success

    assert Customer.find_by first_name: @register_data[:first_name]
  end

  test "should not register customer" do
    register = @register_data
    register[:email] = Faker::Internet.email
    post '/api/customers/',
         params: register.delete(:first_name)
    assert_response 422

    assert_nil Customer.find_by first_name: register[:last_name]
  end
end
