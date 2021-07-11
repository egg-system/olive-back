require 'test_helper'

class DashBoardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :reservations
  fixtures :reservation_details
  fixtures :shifts
  fixtures :reservation_shifts

  setup do
    @staff = Staff.find(9)
    @staff.update(hidden: true)
    sign_in(@staff)

    @reservation = reservations(:tomorrow_one)
  end

  test "should get dashboard index" do
    get dashboards_url
    assert_response :success
  end
end
