require 'test_helper'

class MenuCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @menu_category = menu_categories(:one)
  end

  test "should get index" do
    get menu_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_menu_category_url
    assert_response :success
  end

  test "should create menu_category" do
    assert_difference('MenuCategory.count') do
      post menu_categories_url, params: { menu_category: {  } }
    end

    assert_redirected_to menu_category_url(MenuCategory.last)
  end

  test "should show menu_category" do
    get menu_category_url(@menu_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_menu_category_url(@menu_category)
    assert_response :success
  end

  test "should update menu_category" do
    patch menu_category_url(@menu_category), params: { menu_category: {  } }
    assert_redirected_to menu_category_url(@menu_category)
  end

  test "should destroy menu_category" do
    assert_difference('MenuCategory.count', -1) do
      delete menu_category_url(@menu_category)
    end

    assert_redirected_to menu_categories_url
  end
end
