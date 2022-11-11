class Address < ApplicationRecord
  # クレジットカード支払い者情報
  # アソシエーション
  belongs_to :order
  # //アソシエーション
end
