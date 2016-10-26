class ProductCategoriesController < ApplicationController
  def new
    @all_categories = Category.all
    @product_category = ProductCategory.new
  end

  def create
    category_ids = product_category_params[:category_ids]
    product_id = product_category_params[:product_id]
    # num_of_categories = category_ids.length
    # prev_num_of_prod_cat = ProductCategory.where(product_id: product_id).length

    category_ids.each do | category_id |
      product_category = ProductCategory.new(product_id: product_id)
      product_category.category_id = category_id
      product_category.save
    end

    redirect_to products_path

    # current_num_of_prod_cat = ProductCategory.where(product_id: params[:product_id]).length
    # if current_num_of_prod_cat == (prev_num_of_prod_cat + num_of_categories)
    #   flash[:notice] = "You created added your products to categories"
    #   redirect_to products_path
    # else
    #   render :new
    # end


    # category_ids = params[:category_ids]
    # num_of_categories = category_ids.length
    # prev_num_of_prod_cat = ProductCategory.where(product_id: params[:product_id]).length
    # product_category_params
    #
    # category_ids.each do | category_id |
    #   product_category = ProductCategory.new
    #   product_category.category_id = category_id
    #   product_category.product_id = params[:product_id]
    #
    #   product_category.save
    # end
    #
    # current_num_of_prod_cat = ProductCategory.where(product_id: params[:product_id]).length
    # if current_num_of_prod_cat == (prev_num_of_prod_cat + num_of_categories)
    #   redirect_to products_path
    # else
    #   render :new
    # end

  end

  def edit
    @product = Product.find(params[:product_id])
    @all_product_categories = ProductCategory.where(@product.id)
  end

  def destroy
    @product = Product.find(params[:product_id])
    @all_product_categories = ProductCategory.where(@product.id)
  end


  private

  def product_category_params
    # XXX SKY: This is a nasty hack :( fix it some day
    # Pretty sure we should be able to get the generated form to organize
    # the data this way, but not sure how
    params[:product_category] = {product_id: params[:product_id], category_ids: params[:category_ids]}
    params.require(:product_category).permit(:product_id, category_ids: [])
  end


end
