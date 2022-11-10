class OrdersController < ApplicationController
  before_action :authenticate_user!
  # 「学習メモ」before_action：コントローラーの先に実行させる。もし、ログインしてないと、index以外全てのアクションが使えない
  before_action :not_sold_item, only: [:index, :create]


  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    #エラーがない場合には、クレジットカード支払いを実施し、データ保存後にTOPに戻る処理
    if @order_address.valid? 
      pay_item 
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    # require外の情報は参照するため、mergeする。
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end

  def not_sold_item
    # item(親)>order(子）でネスト構造。
    @item = Item.find(params[:item_id]) 
    #ログインユーザーが出品者か、又はアイテムが販売された場合は、TOPへ戻る処理
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end
end
