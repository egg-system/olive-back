require 'test_helper'

class ReservationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @staff = Staff.find(9)
    sign_in(@staff)

    Shift.transaction do
      # @reservation用のシフト
      Shift.create!({
        date: Date.tomorrow,
        start_at: '10:00:00',
        end_at: '10:30:00',
        store_id: 1,
        staff_id: 9
      })
      Shift.create!({
        date: Date.tomorrow,
        start_at: '10:30:00',
        end_at: '11:00:00',
        store_id: 1,
        staff_id: 9
      })
      # reservationをcreateするようのシフト
      Shift.create!({
        date: Date.tomorrow,
        start_at: '11:00:00',
        end_at: '11:30:00',
        store_id: 1,
        staff_id: 9
      })
      Shift.create!({
        date: Date.tomorrow,
        start_at: '11:30:00',
        end_at: '12:00:00',
        store_id: 1,
        staff_id: 9
      })
    end

    # 日付を動的に設定するためseedsではなくこっちで設定
    @reservation = Reservation.new({
      children_count: 0,
      reservation_comment: 'コメント',
      store_id: 1,
      staff_id: 9,
      customer_id: 1,
      reservation_date: Date.tomorrow,
      start_time: '10:00:00',
      end_time: '11:00:00',
      is_first: 1,
      is_confirmed: 1,
      coupon_ids: [],
      reservation_details_attributes: [{
        menu_id: 1,
        option_ids: []
      }]
    })
    @reservation.build_shifts
    @reservation.save!
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

  test "should show reservation" do
    get reservation_url(@reservation)
    assert_response :success
  end


  test "should update reservation" do
    patch reservation_url(@reservation), params: {
      reservation: {
        reservation_comment: 'コメントを更新'
      }
    }
    assert_redirected_to reservation_url(@reservation)
  end

  test "should destroy reservation" do
    delete reservation_url(@reservation)
    assert_redirected_to reservations_url
  end
end
