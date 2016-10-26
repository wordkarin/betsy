class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])

    @merchant.products.each do |product|
      @item = OrderItem.where(product_id: product.id)
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


  end

  # def create
  # end

end
