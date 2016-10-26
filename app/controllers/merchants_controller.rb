class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])

    # @merchant.products.each do |product|
    #   product = @merchant_product
    #   product.orders.reverse.each do |order|
    #     @order_items = OrderItem.where(order_id = order.id)
    #   end
    # end


  end

  # def create
  # end

end
