class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user,             null: false, foreign_key: true
      t.integer :category_id,         null: false
      t.string :item_name,            null: false
      t.text :item_explain,           null: false
      t.integer :item_status_id,      null: false
      t.integer :price,               null: false
      t.integer :charge_bearer_id,    null: false
      t.integer :sending_area_id,     null: false
      t.integer :delivery_days_id,    null: false
      t.timestamps
    end
  end
end
