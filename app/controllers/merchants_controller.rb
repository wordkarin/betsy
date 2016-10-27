class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    current_user
    @merchant = Merchant.find(params[:id])

    @merchant.products.each do |product|
      @item = OrderItem.where(product_id: product.id)
      @price = product.price
    end

    @item.each do |i|
      i.order_id
      i.quantity
    end 
    #
    # @revenue = {}
    # @order_items.each do |item|
    #   @prdct = Product.find(item.product_id)
    #   merchant = @prdct.merchant_id
    #   price = @prdct.price
    #   quantity = item.quantity
    #   @item_revenue = price * quantity
    #   @revenue[merchant] = @item_revenue
    # end

    if @current_user == nil || @current_user != @merchant
      @user_page = false
    else
      @user_page = true
    end

  end

end
