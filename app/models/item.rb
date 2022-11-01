class Item < ApplicationRecord
  # #アソシエーション
  belongs_to :user
  has_one_attached :image

  # アクティブハッシュ導入
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :item_status
  belongs_to :charge_bearer
  belongs_to :sending_area
  belongs_to :delivery_days
  # //アクティブハッシュ導入

  # #//アソシエーション

  # カラムにバリデーション設定
  with_options presence: true do
    validates :user, :item_name, :item_explain, :image

    with_options numericality: { other_than: 1 } do
      validates :category_id, :item_status_id, :charge_bearer_id, :sending_area_id, :delivery_days_id
    end

    with_options format: { with: /\A[0-9]+\z/ } do
      # /\A[０-９]+\z/ = 全て数値（半角）
      validates :price, numericality: { greater_than: 300, less_than: 9_999_999 }
    end
  end
end
# //カラムにバリデーション設定
