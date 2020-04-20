require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :reservations
  fixtures :reservation_details
  fixtures :shifts
  fixtures :reservation_shifts

  setup do
    @staff = Staff.find(9)
    sign_in(@staff)

    @reservation = reservations(:tomorrow_one)
  end

  test "should get index" do
    get reservations_url
    assert_response :success
  end

  test "should get new" do
    get new_reservation_url, params: { customer_id: 1 }
    assert_response :success
  end

  test "should create reservation" do
    assert_difference('Reservation.count') do
      post reservations_url, params: {
        reservation: {
          children_count: 1,
          reservation_comment: 'コメント',
          store_id: 1,
          staff_id: 9,
          customer_id: 1,
          reservation_date: Date.tomorrow,
          start_time: '11:00:00',
          end_time: '12:00:00',
          is_first: 0,
          is_confirmed: 0,
          coupon_ids: [],
          reservation_details_attributes: [{
            menu_id: 1,
            option_ids: []
          }]
        }
      }
    end

    assert_redirected_to reservation_url(Reservation.last)
  end

  test "should not create reservation because no shift" do
    assert_no_difference('Reservation.count') do
      post reservations_url, params: {
        reservation: {
          children_count: 1,
          reservation_comment: 'コメント',
          store_id: 1,
          staff_id: 9,
          customer_id: 1,
          reservation_date: Date.tomorrow,
          start_time: '13:00:00',
          end_time: '14:00:00',
          is_first: 0,
          is_confirmed: 0,
          coupon_ids: [],
          reservation_details_attributes: [{
            menu_id: 1,
            option_ids: []
          }]
        }
      }
    end
  end

  # menuのskillに紐づくstaffのshiftがない場合
  test "should not create reservation because staff doesn't have enough skill" do
    assert_no_difference('Reservation.count') do
      post reservations_url, params: {
        reservation: {
          children_count: 1,
          reservation_comment: 'コメント',
          store_id: 1,
          staff_id: 3, # 鍼灸師のskillなし
          customer_id: 1,
          reservation_date: Date.tomorrow,
          start_time: '11:00:00',
          end_time: '12:00:00',
          is_first: 0,
          is_confirmed: 0,
          coupon_ids: [],
          reservation_details_attributes: [{
            menu_id: 6, # 鍼灸師のskillが必要
            option_ids: []
          }]
        }
      }
    end
  end

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end


  test "should update reservation" do
    patch reservation_url(@reservation), params: {
      reservation: {
        reservation_comment: 'コメントを更新',
        reservation_details_attributes: [{
          menu_id: 1,
          option_ids: []
        }]
      }
    }
    assert_redirected_to reservation_url(@reservation)

    reservation = Reservation.find(@reservation.id)
    assert_equal 'コメントを更新', reservation.reservation_comment
  end

  test "should destroy reservation" do
    delete reservation_url(@reservation)
    assert_redirected_to reservations_url

    reservation = Reservation.find(@reservation.id)
    assert reservation.canceled_at.present?
  end
end
