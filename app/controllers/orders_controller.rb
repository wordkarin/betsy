class OrdersController < ApplicationController

  def create
    # if @product.stock_quantity > 0 else render product_path(@product.id)
    @product = Product.find_by(id: params[:product_id].to_i)
    #if @product == nil
    @order = @product.orders.new(order_params(params[:order]))
    @order.status = "pending"
    if @order.save
      redirect_to order_items_path
    else
      render product_path(@product.id)
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)

  end
  #
  def edit
    # Edit order, is more like, edit the contact information of the user in the cart. This will be called when they go to checkout their order.
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "Thank you for placing your order with BasketCase. Please come again soon!"
      redirect_to order_path(params[:id])
    else
      redirect_to root_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status)
    # params.permit!
  end
end
