class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index] # 「学習メモ」before_action：コントローラーの先に実行させる。もし、ログインしてないと、index(一覧表示)アクションしか使えない

  def index # 一覧表示ページを表示するリクエストに対応
    @items = Item.all.order(created_at: 'DESC') # indexアクションに、インスタンス変数@itemsを定義し、すべてのitem情報を代入
    # 「学習メモ」：.all.order(created_at: :desc)で日時が新しい順に表示
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
    params.require(:item).permit(:image, :category_id, :item_name, :item_explain, :item_status_id, :charge_bearer_id,
                                 :sending_area_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end
end
