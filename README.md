# テーブル設計 1回目作成完了20221019


## ①Usersテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| nickname              | string      | null: false                    |
| email                 | string      | null: false, unique: true      |
| password              | string      | null: false                    |
| last_name_kana        | string      | null: false                    |
| first_name_kana       | string      | null: false                    |
| last_name_kanji       | string      | null: false                    |
| first_name_kanji      | string      | null: false                    |
| birth_year            | datetime    | null: false                    |
| birth_month           | datetime    | null: false                    |
| birth_day             | datetime    | null: false                    |

### Users Association
- has_many : Items
- has_one : Buyer


## ②Itemsテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| user_id               | references  | null: false, foreign_key: true |
| category_id           | references  | null: false, foreign_key: true |
| band_id               | references  | null: false, foreign_key: true |
| item_name             | string      | null: false                    |
| item_status           | string      | null: false                    |
| price                 | integer     | null: false                    |
| charge_bearer         | string      | null: false                    |
| sending_area          | string      | null: false                    |
| delivery_days         | integer     | null: false                    |



### Items Association
- has_many : Images
- belongs_to : User
- belongs_to : Brand
- belongs_to : Category

## ③Buyersテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| user_id               | references  | null: false, foreign_key: true |
| last_name_kana        | string      | null: false                    |
| first_name_kana       | string      | null: false                    |
| last_name_kanji       | string      | null: false                    |
| first_name_kanji      | string      | null: false                    |
| post_code             | integer     | null: false                    |
| birth_month           | datetime    | null: false                    |
| birth_day             | datetime    | null: false                    |

### 　Buyers Association
- belongs_to : User
- has_one : Card


## ④Cardsテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| buyer_id              | references  | null: false, foreign_key: true |
| payment_info          | string      | null: false                    |

### Cards Association
- belongs_to : Buyer


## ⑤Categorysテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| category_name         | string      | null: false, foreign_key: true |

### Categorys Association
- has_many : Items

## ⑥Brandsテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| brand_name            | string      | null: false, foreign_key: true |

### Brands Association
- has_many : Items

## ⑦Imagesテーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
| item_id               | references  | null: false, foreign_key: true |
| image                 |             | null: false                    |

### Images Association
- belongs_to : Item