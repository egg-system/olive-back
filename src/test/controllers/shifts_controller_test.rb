require 'test_helper'

class ShiftsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :reservations
  fixtures :reservation_details
  fixtures :shifts
  fixtures :reservation_shifts
  setup do
    # 管理者権限でログイン(see 20190602_staff_seeds.rb)
    @staff = Staff.find(9)
    sign_in(@staff)

    @reservation = reservations(:tomorrow_one)
  end

  test "should show view" do
    staffs = Staff.exclude_hidden.all
    get shifts_url
    assert_response :success
  end

  test "check the validity of store and staff displays" do
    @staff.update(hidden: true)
    get shifts_url
    assert_select 'select#store_id option', Store.all.count
    assert_select 'select#staff_id option', Staff.exclude_hidden.all.count
  end
end