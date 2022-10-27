class User < ApplicationRecord #2回目提出：20221028、PW英字+数字組み合わせのみ保存バリデーション追加
  # deviseコマンドでUserモデルを作成した//202210240051
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # //ここまでdevise機能

  # #モデルにてバリデーションの記述を行うこと。OK
  # カラムにバリデーション設定 & 空では保存できない202210241020
  validates :nickname, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } # 半角カタカナのみ保存可能
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ } # 半角カタカナのみ保存可能
  validates :last_name_kanji, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ } # 半角ひらがな、半角カタカナ、漢字以外（数字ABC）のみ保存可能
  validates :first_name_kanji, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]/ } # 半角ひらがな、半角カタカナ、漢字以外（数字ABC）のみ保存可能
  validates :birthday, presence: true



  #PWカラムにのバリデーション、パスワードは必ず半角英数のみ保存する。20221028
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  validates :password, presence: true, format: { with: VALID_PASSWORD_REGEX, message: "must input alphabet and number"}
  #//PWカラムのバリデーション

end


# メモ
# pwとemailはバリデーション不要
#
# ・全角ひらがな、全角カタカナ、漢字の意味
# /\A[ぁ-んァ-ン一-龥]/
#
# ・format: {with: /\A[ぁ-んァ-ン一-龥]/}にすると？
# 「全角ひらがな、全角カタカナ、漢字」は引っかかって保存できず、半角ひらがな、半角カタカナ、漢字以外（数字ABC）のみ保存可能
#
#
# ・全角カタカナ
# /\A[ァ-ヶー－]+\z/
#
# ・format: {with: /\A[ァ-ヶー－]+\z/}にすると？
# 全角カタカナは引っかかって保存できない。半角カタカナのみ保存可能
#
# https://rubular.com/
# 上記サイトにて正規表現チェック可能
