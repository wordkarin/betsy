require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  test "Should render category index page for all categories" do
    get :index
    assert_response :success
  end

  # test "Should render reviews new page for a specific product" do
  #   product = products(:two)
  #
  #   get :new, product_id: product.id
  #   assert_response :success
  # end
end
