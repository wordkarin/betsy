class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id].to_i)
  end

  def edit
    @order = Order.find(params[:id].to_i)
    # needs to be able to select the order_item
  end
end
