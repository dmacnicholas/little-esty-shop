class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    flash[:notice] = "Item successfully updated!"
    if params[:status].nil?
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    else
      redirect_to "/merchants/#{item.merchant_id}/items"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
