require 'test_helper'

class OrderItemsControllerTest < ActionController::TestCase

  # CREATE!!!
  test "should create a new OrderItem" do
    #Needs to be connected from the product page - from here, all info will be provided. => Product page should redireect to Order item new.
  end

  test "should create a new order when one doesn't already exist" do
    # Create a new order with a new order_item
    order_count = Order.all.count.to_i

    needs_order = OrderItem.new(order_id:1, product_id:products(:two).id, quantity:1)
    needs_order.save
    new_order_count = Order.all.count
    assert_equal order_count + 1, new_order_count
  end

  test "should not create a new order if one already exists" do
    # Order_Item with existing Order id should NOT create a new order.
    new_order_count = Order.all.count
    # Not sure why there is an error appearing on the next line, all parts are closed.
    next_order = OrderItem.new(order_id:orders(one:).id, product_id:products(:two).id, quantity:1)
    next_order.save
    new_two = Order.all.count
    assert_equal new_order_count, new_two
  end

  #UPDATE - NOTE - A person should only be able to update the quatity because they shouldn't be able to change the order_id which is unqiue to them and if they want to change the product, they have to go to that product and put it in the order.
  def update

  end 
end

# create update destroy shipped
