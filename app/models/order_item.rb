class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product, presence: true
  # validates_inclusion_of :product_id, :in => Product.all.pluck(:id)
  validates :order, presence: true

  def self.create_order_item(product, order)
    # if product == nil
    #   return false
    # end
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

      if order.products.length >= 1
        #UPDATE PATH
        OrderItem.where(order_id: order.id).each do |item|
          if product.id == item[:product_id]
            item[:quantity] += 1
            if item.save
              return item
            end
          end
        end
        # SUCCESS, but we need to add a new order_item
      end #order.count
      # CREATE PATH
      return OrderItem.create_order_item(product,order) # returns the new order item
  end

end
