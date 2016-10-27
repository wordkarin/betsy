class OrdersController < ApplicationController

  def create
    if session[:order_id] != nil
      render :update
    else
      @product = Product.find_by(id: params[:product_id].to_i)
      @order = @product.orders.new
      @order.status = "pending"
      if @order.save
        OrderItem.create_order_item(@product, @order)
        redirect_to product_path(@product) # might redirect to cart
      else
        flash[:notice] = "Sorry, something that wasn't supposed to happen, happened."
        redirect_to product_path(@product.id)
      end
    end #session
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end

  def edit
    # Edit order, is more like, edit the contact information of the user in the cart. This will be called when they go to checkout their order.
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(sessions[:order_id])
    if @order.status == "pending" || @order != nil
      @product = Product.find(params[:product_id])
          if @order.save
            #SUCCESS
            OrderItem.update_order_item(@product, @order)
            redirect_to order_path(@order)
          else
            render product_path(@product.id) #, error: {notice: "Sorry, something that wasn't supposed to happen, happened."}
          end
    else #(not pending)/nil
      render products_path #, error: {notice: "Sorry, this order is not valid"}
    end #pending/nil?
  end

  private
  def order_params(params)
    params.require(:order).permit(:name, :email, :mailing_address, :cc_last_4, :cc_expire, :status)
  end
end
