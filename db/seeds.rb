# Possibly use create! if we want to get an error on validations for our seed data, or we could turn off validations if we know that our seed data is valid.

require 'csv'
# Merchant seed
CSV.read("seed_csvs/merchant.csv").each do |line|
  id, name, email = line # parallel assignment!
  id = id.to_i # need id to be a fixnum
  merchant = Merchant.new(id: id.to_i, name: name, email: email)

# This is how you would save without using validations
  merchant.save(validate: false)
# Should maybe check here that all of our records got added. 
end

CSV.foreach('./seed_csvs/categories.csv', :headers => true) do |row|
  Category.create(row.to_hash)
end

CSV.read("seed_csvs/products.csv").each do |t|
  Product.create!(name: t[0], price: t[1], stock_quantity: t[2], description: t[3], photo_url: t[4], merchant_id: t[5])
end

CSV.foreach('./seed_csvs/orders.csv', :headers => true) do |row|
    Order.create(row.to_hash)
end

CSV.foreach('./seed_csvs/reviews.csv', :headers => true) do |row|
    Review.create(row.to_hash)
end


# Order_Item
CSV.read("seed_csvs/order_items.csv").each do |t|
  OrderItem.create(order_id: t[0], product_id: t[1], quantity: t[2])
end

#Product_Category
CSV.read("seed_csvs/product_categories.csv").each do |t|
  ProductCategory.create(product_id: t[0], category_id: t[1])
end
