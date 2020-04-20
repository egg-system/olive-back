require 'test_helper'
require_relative '../../helpers/controllers/api/authorization_helper'

class ApiReservationsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper
  fixtures :reservations
  fixtures :reservation_details
  fixtures :shifts

  setup do
    customer = Customer.find(1)
    @auth_tokens = auth_tokens_for_user({ email: customer.email, password: 'test1234' })
    @reservation = reservations(:tomorrow_one)
  end

  test "should get index" do
    get '/api/reservations/', headers: @auth_tokens
    
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post '/api/reservations/', 
        params: {
          children_count: 1,
          reservation_comment: 'コメント',
          store_id: 1,
          customer_id: 1,
          reservation_date: Date.tomorrow,
          start_time: '11:00:00',
          end_time: '12:00:00',
          is_first: 0,
          coupon_ids: [],
          reservation_details_attributes: [{
            menu_id: 1,
            option_ids: []
          }]
        },
        headers: @auth_tokens
    end

    assert_response :success
  end

  test "should not create reservation because no shift" do
    assert_no_difference('Reservation.count') do
      begin
        post '/api/reservations/', 
          params: {
            children_count: 1,
            reservation_comment: 'コメント',
            store_id: 1,
            customer_id: 1,
            reservation_date: Date.tomorrow,
            start_time: '13:00:00',
            end_time: '14:00:00',
            is_first: 0,
            coupon_ids: [],
            reservation_details_attributes: [{
              menu_id: 1,
              option_ids: []
            }]
          },
          headers: @auth_tokens
      rescue => e
      end
    end
  end

  test "should show reservation" do
    get '/api/reservations/', params: { id: @reservation.id }, headers: @auth_tokens
    assert_response :success
  end

  test "should destroy reservation" do
    delete "/api/reservations/#{@reservation.id}", headers: @auth_tokens

    assert_response :success

    reservation = Reservation.find(@reservation.id)
    assert reservation.canceled_at.present?
  end
end
