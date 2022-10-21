# テーブル設計 1回目作成完了20221019 2回目修正1021


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
- has_many : consumer_profiles
- has_one : API(pay.jp)


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
- has_one_attached : images
- belongs_to : user


## ③imagesテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| item                  | references  | null: false, foreign_key: true |
| image                 |             | null: false                    |

### images Association
- belongs_to : item

## ④consumer_profilesテーブル
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| user                  | references  | null: false, foreign_key: true |
| last_name_kana        | string      | null: false                    |
| first_name_kana       | string      | null: false                    |
| last_name_kanji       | string      | null: false                    |
| first_name_kanji      | string      | null: false                    |

### consumer_profiles Association
- belongs_to : user
- has_one : consumer_address

## ⑤consumer_addressesテーブル
| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| consumer_profile      | references  | null: false, foreign_key: true |
| post_code             | integer     | null: false                    |
| prefecture            | integer     | null: false                    |
| city                  | string      | null: false                    |
| address               | string      | null: false                    |
| building_name         | string      | null: false                    |
| phone_number          | integer     | null: false                    |

### consumer_addresses Association
- belongs_to : consumer_profile
