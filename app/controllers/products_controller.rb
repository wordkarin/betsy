class ProductsController < ApplicationController
  def index
    #shows all the products in the site
  end

  def edit
    # This is the page where a merchant can edit their own product, will have an authorization to make sure merchant's id matches product's merchant_id
  end

  def show
    # This is the individual product page
  end

  def update
    # This is the PATCH call when a merchant updates their product
  end

  def retired
    # This is the PATCH call when a merchant retires a product
  end
end
