class OrderAddress # 「購入テーブル」と「クレジットカード決済支払い者テーブル」を一度に保存できる為のファイル
  # form_withメソッドに対応する機能とバリデーションを行う機能を持たす
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token # 保存したいカラム名

  with_options presence: true do
    # orderモデルのバリデーション
    validates :user_id
    validates :item_id
    # addressモデルのバリデーション : クレジットカード支払い者情報
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    # 電話番号は、10桁以上11桁以内の半角数値のみ保存可能
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: 'is invalid' }
    # トークンのバリデーション
    validates :token
  end
  # // form_withメソッドに対応する機能とバリデーションを行う機能を持たす

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    # ストロングパラメーターでデータが運ばれ、それらの保存のタイミングで「order_id」が生成と保存される。
    Address.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                   building_name: building_name, phone_number: phone_number)
  end
end

# 「学習メモ」：正規表現チェッカー：https://rubular.com/
