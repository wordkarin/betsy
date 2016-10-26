class OrdersController < ApplicationController

  def create
    # if @product.stock_quantity > 0 else render product_path(@product.id)
    @product = Product.find_by(id: params[:product_id].to_i)
    #if @product == nil
    @order = @product.orders.new
    @order.status = "pending"
    if @order.save
      OrderItem.get_order_item(@product, @order)
      # redirect_to product_order_items_path(@product)
      redirect_to product_path(@product)
    else
      render product_path(@product.id)
    end
  end
  # def show
  #   @order = Order.find(params[:id].to_i)
  # end
  #
  # def edit
  #   @order = Order.find(params[:id].to_i)
  #   # needs to be able to select the order_item
  # end

  private
  def order_params(params)
    # params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status)
    params.permit!
  end
end
