# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

CSV.foreach('./seed_csvs/orders.csv', :headers => true) do |row|
    Order.create(row.to_hash)
end

CSV.foreach('./seed_csvs/categories.csv', :headers => true) do |row|
    Category.create(row.to_hash)
end

CSV.foreach('./seed_csvs/reviews.csv', :headers => true) do |row|
    Review.create(row.to_hash)
end

CSV.read("seed_csvs/products.csv").each do |t|
  Product.create(name: t[0], price: t[1], stock_quantity: t[2], description: t[3], photo_url: t[4], merchant_id: t[5])
end

# Merchant seed
CSV.read("seed_csvs/merchant.csv").each do |line|
  id, name, email = line # parallel assignment!
  id = id.to_i # need id to be a fixnum
  merchant = Merchant.new(id: id, name: name, email: email)

  merchant.save
end
