require 'test_helper'

class CouponHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon_history = coupon_histories(:one)
  end

  test "should get index" do
    get coupon_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_coupon_history_url
    assert_response :success
  end

  test "should create coupon_history" do
    assert_difference('CouponHistory.count') do
      post coupon_histories_url, params: { coupon_history: {  } }
    end

    assert_redirected_to coupon_history_url(CouponHistory.last)
  end

  test "should show coupon_history" do
    get coupon_history_url(@coupon_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_coupon_history_url(@coupon_history)
    assert_response :success
  end

  test "should update coupon_history" do
    patch coupon_history_url(@coupon_history), params: { coupon_history: {  } }
    assert_redirected_to coupon_history_url(@coupon_history)
  end

  test "should destroy coupon_history" do
    assert_difference('CouponHistory.count', -1) do
      delete coupon_history_url(@coupon_history)
    end

    assert_redirected_to coupon_histories_url
  end
end
