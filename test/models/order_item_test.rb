require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Must belong to a product, ie a valid product id" do
    order_item = OrderItem.new(order_id: 1, quantity: 2)
    order_item = OrderItem.new(order_id: 1, product_id: "a", quantity: 2)
    assert_not order_item.valid?
  end

  # I feel that making sure that the OrderItem is associated with a valid product_id and order_id. I think it might be helpful to talk about if this is useful.
  test "Must belong to a valid product" do
    order_item = OrderItem.new(product_id: 1, order_id: 1, quantity: 2)
    order_item2 = OrderItem.new(product_id: 4, order_id: 1, quantity: 2)
    order_item.save
    order_item2.save
    assert_includes Product.all, Product.where(order_item.order_id).first
    assert_not Product.all.pluck(:id).include? Product.where(order_item2.order_id).first
  end

  test "Must belong to an Order, ie a valid order id" do
    order_item = OrderItem.new(product_id: 1, quantity: 2)
    assert_not order_item.valid?
  end

  test "Must belong to a valid order" do
    order = Order.new(id: 4)
    order.save
    # may need to include user_id when combining tests, but here it is said to be invalid
    order_item = OrderItem.new(product_id: 1, order_id: 4, quantity: 2)
    order_item.save
    order_item2 = OrderItem.new(product_id: 1, order_id: 3, quantity: 2)
    order_item2.save
    assert_includes Order.all, Order.where(order_item.order_id).first
    assert_empty Order.where(order_item2.order_id)
  end

  test "Should reject an OrderItem with no quantity" do
    order_item = OrderItem.new(order_id: 1, product_id: 1)
    assert_not order_item.valid?
  end

  test "Should reject an OrderItem with a quantity other than an integer" do
    order_item = OrderItem.new(order_id: 1, product_id: 1, quantity: "a")
    order_item2 = OrderItem.new(order_id: 1, product_id: 1, quantity: false)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end

  test "Should reject an OrderItem with a quantity less than or equal to 0" do
    order_item = OrderItem.new(order_id: 1, product_id: 1, quantity: -1)
    order_item2 = OrderItem.new(order_id: 1, product_id: 1, quantity: 0)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end
end
