class ItemsController < ApplicationController
  def index
    @item = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
       @item.save
       redirect_to root_path
    else
      render :new
    end
  end


private
  def item_params
    params.require(:item).permit(:image, :category_id, :item_name, :item_explain, :item_status_id, :charge_bearer_id, :sending_area_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end
end





