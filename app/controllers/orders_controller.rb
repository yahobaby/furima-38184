class OrdersController < ApplicationController
  before_action :authenticate_user!
  # 「学習メモ」before_action：コントローラーの先に実行させる。もし、ログインしてないと、全てのアクションが使えない
  before_action :order_item, only: [:index, :create]

  def index
  end

  def create
  end

  def order_item
    # 他のコントローラーで生成されたitemを使う為、createアクションに定義。
    @item = Item.find(params[:item_id])
  end
end
