class Order < ActiveRecord::Base
  has_many :order_items
  has_many :products, :through => :order_items

  validates_presence_of :order_items, presence: true
  validates_presence_of :products

  validates :status, :presence => true, inclusion: { in: %w(pending paid completed cancelled) }
  # validates :name
  # validates :email
  # validates_length_of :cc_last_4, :is => 4, #should this be an integer
  # validates :cc_expire
end
