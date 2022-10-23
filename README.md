# テーブル設計 1回目作成完了20221019 2回目修正1020 3回目修正1022 4回目修正1023

## ①usersテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| nickname              | string      | null: false                    |
| email                 | string      | null: false, unique: true      |
| encrypted_password    | string      | null: false                    |
| last_name_kana        | string      | null: false                    |
| first_name_kana       | string      | null: false                    |
| last_name_kanji       | string      | null: false                    |
| first_name_kanji      | string      | null: false                    |
| birthday              | date        | null: false                    |


### users Association
- has_many : items
- has_many : orders


## ②itemsテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| user                  | references  | null: false, foreign_key: true |
| category_id           | integer     | null: false                    |
| brand_id              | integer     | null: false                    |
| item_name             | string      | null: false                    |
| item_explain          | text        | null: false                    |
| item_status_id        | integer     | null: false                    |
| price                 | integer     | null: false                    |
| charge_bearer_id      | integer     | null: false                    |
| sending_area_id       | integer     | null: false                    |
| delivery_days_id      | integer     | null: false                    |

### items Association
- belongs_to : user
- has_one : order

## ③ordersテーブル
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| user                  | references  | null: false, foreign_key: true |
| item                  | references  | null: false, foreign_key: true |

### orders Association
- belongs_to : user
- has_one : item
- has_one : address

## ④addressesテーブル
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| order                 | references  | null: false, foreign_key: true |
| post_code             | string      | null: false                    |
| prefecture_id         | integer     | null: false                    |
| city                  | string      | null: false                    |
| address               | string      | null: false                    |
| building_name         | string      |                                |
| phone_number          | string      | null: false                    |

### addresses Association
- belongs_to : order
