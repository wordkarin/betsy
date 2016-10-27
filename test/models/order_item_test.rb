require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "create a new product with valid data" do
    assert order_items(:one).valid?
    assert order_items(:two_true).valid?
  end

  test "Should reject an OrderItem with no quantity" do
    item = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id)
    assert_not item.valid?
  end

  test "Should reject an OrderItem with a quantity other than an integer" do
    order_item = OrderItem.new(product_id: products(:two).id, order_id: orders(:two).id, quantity: "a")
    order_item2 = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id, quantity: false)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end

  test "Must belong to a product AND order" do
    item = OrderItem.new(product_id: products(:one).id, order_id: orders(:two).id, quantity: 1)
    assert item.valid?
    item_two = OrderItem.new(product_id: 1, order_id: orders(:two), quantity: 1)
    item_three = OrderItem.new(product_id: products(:one).id, order_id: 1, quantity: 1)
    assert_not item_two.valid?
    assert_not item_three.valid?
  end

  test "Should reject an OrderItem with a quantity less than or equal to 0" do
    order_item = OrderItem.new(product_id: products(:two), order_id: orders(:two), quantity: -1)
    order_item2 = OrderItem.new(product_id: products(:one), order_id: orders(:two), quantity: 0)
    assert_not order_item.valid?
    assert_not order_item2.valid?
  end

  test "the method create_order_item should create a new OrderItem instance" do
    product = products(:one)
    order = orders(:one)
    #can we compare two different objects using assert_equal?
    assert_difference('OrderItem.count', 1) do
      OrderItem.create_order_item(product, order)
    end
  end

  #_____________________________________________________#
  # @todo write the code to pass these tests
  #_____________________________________________________#

  test "the method create_order_item should not create a new order item if there is already one with current order and product" do
    product = products(:one)
    order = orders(:one)

    assert_difference('OrderItem.count', 1) do
      OrderItem.create_order_item(product, order)
      OrderItem.create_order_item(product, order)
    end
  end

  # test "the method update_order_item should update the quantity of an order item by one when the product is added to the order a second time" do
  #   product = products(:one)
  #   order = orders(:one)
  #   order_item = OrderItem.create_order_item(product, order)
  #
  #   assert_equal(order_item[:quantity], 2) do
  #     order_item.update_order_item(product, order)
  #   end
  #
  # end
  #
  # test "the method update_order_item should not update an order item if the order[:status] is 'paid'" do
  #   product = products(:one)
  #   order = orders(:one)
  #   order[:status] = "paid"
  #   order_item = OrderItem.update_order_item(product, order)
  #   assert_not order_item.valid?
  #
  # end
  #
  # test "the method update_order_item should not update an order item if the order[:status] is 'completed'" do
  #   product = products(:one)
  #   order = orders(:one)
  #   order[:status] = "completed"
  #   order_item = OrderItem.update_order_item(product, order)
  #   assert_not order_item.valid?
  #
  # end
  #
  # test "the method update_order_item should not update an order item if the order[:status] is 'cancelled'" do
  #   product = products(:one)
  #   order = orders(:one)
  #   order[:status] = "cancelled"
  #   order_item = OrderItem.update_order_item(product, order)
  #   assert_not order_item.valid?
  #
  # end


end
