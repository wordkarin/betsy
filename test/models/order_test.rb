require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "create a new order with valid input values" do
    assert products(:one).valid?
   end

  test "Cannot create a order without a status" do
    order = Order.new(name: "Penny")
    assert_not order.valid?
  end

  test "Cannot create a order without an incorrect status" do
    order = Order.new(status: "Penny")
    assert_not order.valid?
  end

  test "Cannot change an order's status to an incorrect value" do
    order = orders(:one)
    order.status = "Penny"
    order.save
    assert_not order.valid?
  end

# --------------------NOT SURE ABOUT THESE----------------------
  test "Order should have a relationship with products" do
    order = orders(:one)
    assert_respond_to(order, :products)
  end

  test "Order should return correct number of products" do
    order = orders(:one)
    assert_equal(order.products.length, 2)
  end

  test "Cannot create a order without an item" do
    order = Order.new(status: "pending")
    assert_not order.valid?
  end

  test "Should throw exception if creating order and no order_items are present" do
    order = orders(:two)
    assert_throws(Exception,'is empty') {throw Exception if order.products.empty?}
  end

end
