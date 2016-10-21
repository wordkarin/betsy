require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "Must belong to a product, ie a valid product id" do
    order_item = OrderItem.new(order_id: 1, quantity: 2)
    assert_not order_item.valid?
  end

  # test "Must belong to a valid product" do
  #   product = Product.new(id: 1 ,name: "Cheese", price: 670)
  #   product.save
  #   # may need to include user_id when combining tests, but here it is said to be invalid
  #   order_item = OrderItem.new(product_id: 1, order_id: 1, quantity: 2)
  #   order_item.save
  #   assert_includes Product.all, Product.find(order_item.order_id)
  # end

  test "Must belong to an object, ie a valid object id" do
    order_item = OrderItem.new(product_id: 1, quantity: 2)
    assert_not order_item.valid?
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
