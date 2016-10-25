class ProductCategoriesController < ApplicationController
  def new
    @all_categories = Category.all
    @product_category = ProductCategory.new
  end

  def create

  end

  def destroy
  end


  
end
