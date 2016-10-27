class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    current_user
    @merchant = Merchant.find(params[:id])

    if @current_user == nil || @current_user != @merchant
      @user_page = false
    else
      @user_page = true
    end

  end

end
