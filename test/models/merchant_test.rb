require 'test_helper'

class MerchantTest < ActiveSupport::TestCase

  test "Created merchant can have a name and an email" do
    merchant = Merchant.create!(name: "Gingham Suppliers", email: "gingham@suppliers.ya")
    assert merchant.valid?
  end

  test "Merchant is not valid when empty" do
    merchant = Merchant.new
    assert_not merchant.valid?
  end

  test "Merchants must be created with unique name and email must be unique" do
    valid_merchant = Merchant.create!(name: "Gingham Suppliers", email: "gingham@suppliers.ya")
    invalid_merchant = Merchant.new(name: "Gingham Suppliers", email: "gingham@suppliers.ya")
    merchant_invalid_name = Merchant.new(name: "Gingham Suppliers", email: "picnic@suppliers.ya")
    merchant_invalid_email = Merchant.new(name: "Picnic Suppliers", email: "gingham@suppliers.ya")
    assert_not invalid_merchant.valid?
    assert_not merchant_invalid_name.valid?
    assert_not merchant_invalid_email.valid?
  end

  test "Many merchants can be saved on the database, and be individually retrieved" do
    merchant = Merchant.new(name: "Gingham Suppliers", email: "gingham@suppliers.ya")
    merchant2 = Merchant.new(name: "Strawberries and Champagne", email: "little.shop@strawberries.fr")

    assert merchant.save
    assert merchant2.save
    assert_includes Merchant.all, merchant
    assert_includes Merchant.all, merchant2
  end

end
