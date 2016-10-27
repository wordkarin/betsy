require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  test "should be able to create a new order" do
    post_params = {product_id: products(:three).id}
    post :create, post_params
    assert_response :redirect
  end

  test "creating a new order should increase the number of orders by 1" do
    assert_difference 'Order.count', 1 do
      post_params = {product_id: products(:three).id}
      post :create, post_params
    end
  end

  test "A new order will have status 'pending'" do
    post_params = {product_id: products(:one).id}
    post :create, post_params
    order = Order.all.last[:status] = "cancelled"
    post_params = {product_id: products(:three).id}
    post :create, post_params
    assert_equal Order.all.last[:status], "pending"
  end

  test "A new order will not be created if product is nil or has no stock" do
    product = products(:one)
    product[:stock_quantity] = 0
    order_count = Order.count
    assert_equal order_count, Order.count do
      post_params = {product_id: product.id}
      post :create, post_params
    end
  end

  test "A new order will be created if a other current order is not an open (not yet cancelled or paid) order" do
    # # @todo discuss how to test/implement this
    # # The first order
    # post_params = {product_id: products(:one).id}
    # post :create, post_params
    # # Closing the first order
    # order_cancel = Order.all.last
    # order_cancel[:status] = "cancelled"
    #
    # assert_not order_cancel.status?
    #
    # # The second order
    # post_params = {product_id: products(:one).id}
    # post :create, post_params
    #
    # order_paid = Order.all.last
    # order_paid[:status] = "paid"
    #
    # assert_not order_paid.status?
  end

# UPDATE _____________________ #

  test "updating an order should redirect to the order page" do
    order = orders(:one)
    product_id = products(:one).id
    post_params = {id: order.id, product_id: product_id}
    post :update, post_params

    assert_response :redirect
  end

  test "updating an order with a new product should add it to the order" do
    product = products(:one)
    new_post_params = {product_id: product.id}
    post :create, new_post_params
    order = Order.all.last

    product_id = products(:two).id
    update_post_params = {id: order.id, product_id: product_id}
    post :update, update_post_params

# currently comparing two different objects
    assert_equal OrderItem.all.last[:product_id], product_id
  end

  # test "updating an order with a new product should only be possible when the order is 'pending'" do
  #
  # end

  test "create will send back to product#show if stock_quantity is zero" do
    # is this a model test?
  end

# test "it can not create more than one order per session" do
#   # @todo COME BACK here!!!!!
# end

#   test "should update the order when the order_item changes" do
#   end
#

test "should get show" do
  get :show, id: orders(:one).id
  assert_response :success
end

test "should get edit" do
  get :edit, id: orders(:one).id
  assert_response :success
end
#
#   # Return to non-restful routes.
#   test "an order is marked completed when all items in the order have been shipped" do
#
#   end
#
#   test "an order is cancelled when the session ends before being paid for" do
#
#   end
#
#   test "an order is paid for when the CC info is provided" do
#
#   end
end
#
# # create edit show update completed cancelled paid
