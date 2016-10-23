class OrderItemsController < ApplicationController

  # def create
  #   @params = params
  #   @order_item = OrderItem.new(post_params(params))
  #   if OrderItem.where(order_id: params[:id]).length == 0
  #     new_order = Order.new # with those params
  #     new_order.save
  #   end
  #   redirect_to product_path(params[:id])
  # end

  private
  def order_item_params(params)
    params.require(:order_item).permit(:quantity)
  end 
end
