class ProductCategoriesController < ApplicationController
  def new
    @all_categories = Category.all
    @product_category = ProductCategory.new
  end

  def create
    @product_category = ProductCategory.new(product_category_params)
    raise
  end

  def destroy
  end

  private

  def product_category_params
    params.require(:product_category).permit(:category)
  end


end
