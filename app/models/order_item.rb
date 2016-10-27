class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product, presence: true
  # validates_inclusion_of :product_id, :in => Product.all.pluck(:id)
  validates :order, presence: true

  def self.create_order_item(product, order)
    if product == nil
      return false
    end
    # OrderItem.where(order_id: order.id).each do |item|
    #   if product.id == item[:product_id]
    #     return false
    #   end
    # end
    order_item = product.order_items.new(quantity: 1)
    order_item.order_id = order.id
    if order_item.save
      return order_item
    else
      return false
    end
  end

  def self.update_order_item(product, order)
    if order == nil || product == nil
      return false
    end
    if product.stock_quantity > 0
      if order.products.length > 1
        #SUCCESS
        # use enumerable?
        OrderItem.where(order_id: order.id).each do |item|
          if product.id == item[:product_id]
            item[:quantity] += 1
            if item.save
              return item
            end
          end
        end
        # SUCCESS, but we need to add a new order_item
        return Order.create_order_item(product,order) # returns the new order item
      end #order.count
    end #no stock
    return false
  end

end
