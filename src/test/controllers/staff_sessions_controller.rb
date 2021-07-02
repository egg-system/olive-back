require 'test_helper'

class StaffSessionsControllerTest < ActionDispatch::IntegrationTest

  test "should show admin login view" do
    get new_staff_session_url
    assert_response :success
  end

  test "should admin login" do
    post staff_session_url, params: [
      "staff[login_store_id]": 1,
      "staff[login]": 'akagawa',
      "staff[password]": 'password'
    ]
    assert_response :success
  end

end