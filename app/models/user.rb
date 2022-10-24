class User < ApplicationRecord
  # deviseコマンドでUserモデルを作成した//202210240051
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #//ここまでdevise機能


  ##モデルにてバリデーションの記述を行うこと。OK
  #カラムにバリデーション設定 & 空では保存できない202210241020
  validates :nickname, presence: true 
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kanji, presence: true
  validates :first_name_kanji, presence: true
  validates :birthday, presence: true
  
end
