class OrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :product, presence: true
  # validates_inclusion_of :product_id, :in => Product.all.pluck(:id)
  validates :order, presence: true

  def self.get_order_item(product, order)
    order_item = product.order_items.new(quantity: 1)
    order_item.order_id = order.id
    if order_item.save
      return order_item
    else
      return false
    end

  end
end
