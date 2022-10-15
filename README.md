# テーブル設計 


##  テーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
|                  | string      |                                |
|     | string      | null: false, unique: true      |
|                   | string      | null: false                    |
|                | text        | null: false                    |
|             | text        | null: false                    |
|               | text        | null: false                    |

###  Association
- has_many :
- has_many :


##  テーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
|                | text        | null: false                    |
|              | references  | null: false, foreign_key: true |
|                   | references  | null: false, foreign_key: true |

###  Association
- belongs_to :
- belongs_to :

##  テーブル

| Column                | Type        | Options                        |
| --------------------- | ----------- | ------------------------------ |
|                  | string      | null: false                    |
|             | text        | null: false                    |
|                | text        | null: false                    |
|                   | references  | null: false, foreign_key: true |

### 　Association
- belongs_to :
- has_many :
