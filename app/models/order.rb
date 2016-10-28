class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, :through => :order_items

  # validates :order_items, presence: true
  # REMOVING ORDER_ITEMS validates or else we have a chicken and egg scenario.
  # validates :order_items, :length => { :minimum => 1 }


  validates :status, :presence => true, inclusion: { in: %w(pending paid completed cancelled) }

  def self.check_status(order)
    order.order_items.each do |item|
      if item.shipping_status == false
        order.status = "paid"
        order.save
        break
      else
        order.status = "completed"
        order.save
      end
    end
  end

private
  def card_adjust(cc_last_4)

  end
  # validates :name
  # validates :email
  # validates_length_of :cc_last_4, :is => 4, #should this be an integer
  # validates :cc_expire
end
