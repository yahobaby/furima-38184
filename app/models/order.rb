class Order < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :item
  has_one :address # // :address - クレジットカード支払い者情報
  # //アソシエーション
end
