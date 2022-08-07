class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.new(discount_params)
    if discount.save
      redirect_to "/merchants/#{merchant.id}/discounts"
    else
      redirect_to "/merchants/#{merchant.id}/discounts/new"
      flash[:error] = "Error #{discount.errors.full_messages.join(", ")}"
    end
  end

  private
  def discount_params
    params.permit(:percent, :threshold, :merchant_id)
  end

end
