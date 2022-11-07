class Order < ApplicationRecord
  #アソシエーション
  belongs_to :user
  belongs_to :item
  has_one :address
  #//アソシエーション

  # カラムにバリデーション設定 & 空では保存できない
  validates :item, presence: true
  #// カラムにバリデーション設定 & 空では保存できない
end
