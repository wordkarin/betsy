class ReviewsController < ApplicationController
  def index
    @reviews_by_product = Review.where(product_id: params[:product_id])
    @product = @reviews_by_product.first.product
  end

  def show

  end

  def new
    @review = Review.new
  end

  def create
    #exception handeling:
    begin
      @product = Product.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      render "/errors/product_not_found"
    end

    @review = Review.new(review_params)
    @product.reviews << @review

    if @review.save
      redirect_to product_reviews_path
    else
      render :new
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :title, :body)
  end
end
