# テーブル設計 1回目作成完了20221019 2回目修正1021 3回目修正

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
| band_id               | integer     | null: false                    |
| item_name             | string      | null: false                    |
| item_status           | string      | null: false                    |
| price                 | integer     | null: false                    |
| charge_bearer         | integer     | null: false                    |
| sending_area          | integer     | null: false                    |
| delivery_days         | integer     | null: false                    |

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
| last_name_kana        | string      | null: false                    |
| first_name_kana       | string      | null: false                    |
| last_name_kanji       | string      | null: false                    |
| first_name_kanji      | string      | null: false                    |
| post_code             | integer     | null: false                    |
| prefecture            | integer     | null: false                    |
| city                  | string      | null: false                    |
| address               | string      | null: false                    |
| building_name         | string      | null: false                    |
| phone_number          | integer     | null: false                    |

### addresses Association
- belongs_to : order