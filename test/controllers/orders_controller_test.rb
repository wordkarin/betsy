require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  test "should get show" do
    get :show, id: orders(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: orders(:one).id
    assert_response :success
  end

end
