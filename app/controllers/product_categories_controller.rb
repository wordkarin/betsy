class ProductCategoriesController < ApplicationController
  def new
    @all_categories = Category.all
    @product_category = ProductCategory.new
  end

  def create
    category_ids = params[:category_ids]
    num_of_categories = category_ids.length
    prev_num_of_prodcat = ProductCategory.where(product_id: params[:product_id]).length

    category_ids.each do | category_id |
      product_category = ProductCategory.new
      product_category.category_id = category_id
      product_category.product_id = params[:product_id]

      product_category.save
    end

    current_num_of_prodcat = ProductCategory.where(product_id: params[:product_id]).length
    if current_num_of_prodcat == (prev_num_of_prodcat + num_of_categories)
      redirect_to products_path
    else
      render :new
    end

  end

  def destroy
  end

  private

  def product_category_params
    params.require(:product_category).permit(:product_id, :category_ids[])
  end


end
