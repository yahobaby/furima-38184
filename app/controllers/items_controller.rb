class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show] # 「学習メモ」before_action：コントローラーの先に実行させる。もし、ログインしてないと、index(一覧表示),show(詳細表示)アクションしか使えない

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

  def show
    @item = Item.find(params[:id]) # @itemテーブル内の指定したレコードからidカラムの値を取得して@userに代入する
  end

  def edit # 学習メモ：投稿編集ページを表示するリクエストに対応
    @item = Item.find(params[:id]) # @itemテーブル内の指定したレコードからidカラムの値を取得して@userに代入する
    if @item.user_id == current_user.id # itemを出したユーザーと、ログインユーザーが同一の場合のみ、編集ページへアクセス許可
    else
      redirect_to root_path
    end
  end

  def update # 学習メモ：データの編集を行うリクエストに対応
    @item = Item.find(params[:id]) # @itemテーブル内の指定したレコードからidカラムの値を取得して@userに代入する
    if @item.update(item_params)
      redirect_to item_path(@item.id) # itemの編集に成功したら、当該アイテムの詳細ページへ飛ぶ
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :category_id, :item_name, :item_explain, :item_status_id, :charge_bearer_id,
                                 :sending_area_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end
end
