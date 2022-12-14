class CreateAddresses < ActiveRecord::Migration[6.0]
  #クレジットカード支払い者情報
  def change
    create_table :addresses do |t|
      t.references :order,            null: false, foreign_key: true
      t.string     :post_code,        null: false
      t.integer    :prefecture_id,    null: false #都道府県
      t.string     :city,             null: false
      t.string     :address,          null: false
      t.string     :building_name
      #ビルネームは空欄でも問題なし
      t.string     :phone_number,     null: false
      t.timestamps
    end
  end
end
