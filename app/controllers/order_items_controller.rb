class OrderItemsController < ApplicationController

  def create
    @order = Order.find_by(id: params[:order_id].to_i)
    @order_item = @order.order_items.new #here need params
    # @order_item.quantity += 1
    if @order_item.save
      # SUCCESS # to order page?
      # redirect_to product_path(SOME PRODUCT ID) #not sure how it finds it
    else
      # render # same but with flash message?
      # NO SUCCESS
    end


    # if Order.where(id: params[:id]).length == 0
    #   new_order = Order.new # with those params
    #   new_order.save
    # end

    # @todo RETURN WITH PARAMS

    # raise
    # redirect_to product_path(params[:id])
  end
#   #
#   # # Talk about the routes
#   # def update
#   #   @order_item = OrderItem.find(params[:id].to_i)
#   #   @quantity_available = Product.find(@order_item.product_id).stock_quantity
#   #   if @order_item.quantity > @quantity_available
#   #     raise "You may not add a quantity to the order that is greater than the stock quantity."
#   #   elsif @order_item.save
#   #       redirect_to order_path
#   #       # I think there needs to be a parameter here, but what is it? It is not the one displayed because that is associated with the OrderItem.
#   #   else
#   #     redirect_to order_item_path(params[:id].to_i)
#   #   end
#   # end
#   #
#   # def destroy
#   #   order_status = Order.find(OrderItem.find(params[:id].to_i).product_id).status
#   #   order_count = OrderItem.where(params[:id].to_i).product_id).length
#   #   if order_status == "paid" || order_status == "completed" || order_status == "cancelled"
#   #     raise "You can't delete an item that has already been paid for"
#   #   elsif order_count = 1
#   #     Order.find(OrderItem.find(params[:id].to_i).product_id).cancelled
#   #
#   #   else
#   #     redirect_to :action=> :index
#   #   end
#   # end
#   #
#   #
#   #
#   #
  private
  def order_item_params(params)
    params.permit!
    # params.require(:order_item).permit(:quantity)
  end
end
