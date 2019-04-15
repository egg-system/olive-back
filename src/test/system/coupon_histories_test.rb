require "application_system_test_case"

class CouponHistoriesTest < ApplicationSystemTestCase
  setup do
    @coupon_history = coupon_histories(:one)
  end

  test "visiting the index" do
    visit coupon_histories_url
    assert_selector "h1", text: "Coupon Histories"
  end

  test "creating a Coupon history" do
    visit coupon_histories_url
    click_on "New Coupon History"

    click_on "Create Coupon history"

    assert_text "Coupon history was successfully created"
    click_on "Back"
  end

  test "updating a Coupon history" do
    visit coupon_histories_url
    click_on "Edit", match: :first

    click_on "Update Coupon history"

    assert_text "Coupon history was successfully updated"
    click_on "Back"
  end

  test "destroying a Coupon history" do
    visit coupon_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Coupon history was successfully destroyed"
  end
end
