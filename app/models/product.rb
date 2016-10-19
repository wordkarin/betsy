class Product < ActiveRecord::Base
  has_many :reviews
  belongs_to :merchant

  has_many :order_items
  has_many :orders, :through => :order_items

  has_many :product_categories
  has_many :categories, :through => :product_categories
end
