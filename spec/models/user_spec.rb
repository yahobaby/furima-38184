# 「学習メモ」テストコード実行 % bundle exec rspec spec/models/user_spec.rb

# 学習メモ
# RSpecでモデル、ビュー、コントローラーのテストを行うためには、rails_helper.rbというファイルを読み込む必要があり
# require 'rails_helper'と記述することで、ファイルを読み込める。
# rails_helper : Rspecを用いてRailsの機能をテストするとき、共通設定を書いておくファイル。各テスト用ファイルでspec/rails_helper.rbを読み込むことで、共通の設定やメソッドを適用する。
# rails gコマンドでテストファイルを生成すると、rails_helperの読み込み記述が、自動追加
require 'rails_helper'

RSpec.describe User, type: :model do
  before do # 「なぜ必要か」/spec/factories/user.rbでFactoryBotを用いて定義した共通記述を切り出し、Utemのインスタンスを生成、各Exampleで使用する為
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do # 学習メモ：describeとは、テストコードグループ分けを行うメソッド。どの機能に対してのテストを行うかをdescribeでグループ分けし、その中に各テストコードを記述
    context '新規登録ができるとき' do
      it '全て正しく入力されると、登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録ができないとき' do
      it 'nicknameが空では登録できない' do
        # 学習メモ：itとは？describeメソッド同様、グループ分けを行うメソッド。itはより詳細に、describeメソッドに記述した機能において、どのような状況のテストを行うかを明記
        # 学習メモ：itメソッドで分けたグループを、exampleとも呼ぶ
        @user.nickname = '' # 空欄だと「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = '' # 空欄だと「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'メールアドレスが一意性でないと登録できない' do
        # 上記の意味は？同じメールアドレスが重複してるならば、登録できない
        @user.save # @userでインスタンスを作って、
        another_user = FactoryBot.build(:user) # また違うuserのインスタンスを作り
        another_user.email = @user.email      # そのuserと違うuserのemailが同じなら
        another_user.valid?                   # 「異常になる＝緑」
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスに@を含まないと登録できない' do
        @user.email = 'hellotechcamp' # @が入ってないと、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'パスワードが空では登録できない' do
        @user.password = '' # 空欄だと「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'パスワードが６文字以上でなければ登録できない' do
        @user.password = '12345' # PWが5文字以下で
        @user.password_confirmation = '12345' # PWの確認もPWと同じ値の５文字以下の数字だと、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'パスワードとパスワード確認の値は一致しなくては登録できない' do
        @user.password = '123456' # userのPWと
        @user.password_confirmation = '1234567' # userのPWの確認が違うと、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '英字のみではパスワード入力できず、登録できない' do
        @user.password = 'hellotechcamp' # passwordを英字のみに入力し
        @user.password_confirmation = 'hellotechcamp' # password確認もpwと同じ英字のみで入力すると、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must input Half size alphabet and number')
      end

      it '数字のみではパスワード入力できず、登録できない' do
        @user.password = '1234567' # passwordを数字のみに入力し
        @user.password_confirmation = '1234567' # password確認もpwと同じ数字のみで入力すると、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must input Half size alphabet and number')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'loveｔｅｃｈｃａｍｐ' # passwordを英字のみに入力し
        @user.password_confirmation = 'loveｔｅｃｈｃａｍｐ' # password確認もpwと同じ英字のみで入力すると、「異常になる＝緑」
        @user.valid?
        # binding.pry
        expect(@user.errors.full_messages).to include('Password must input Half size alphabet and number')
      end

      it 'お名前_漢字「名字」は入力しないと登録できない' do
        @user.last_name_kanji = '' # 漢字の名字が空欄なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
      end

      it 'お名前_漢字「名前」は入力しないと登録できない' do
        @user.first_name_kanji = '' # 漢字の名前が空欄なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kanji can't be blank")
      end

      it 'お名前_漢字「名字」は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.last_name_kanji = 'kanji' # 漢字の名字が英字なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kanji is invalid')
      end

      it 'お名前_漢字「名前」は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.first_name_kanji = 'kanji' # 漢字の名前が英字なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kanji is invalid')
      end

      it 'お名前_漢字「名字」は入力しないと登録できない' do
        @user.last_name_kana = '' # カナの名字が空欄なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'お名前_漢字「名前」は入力しないと登録できない' do
        @user.first_name_kana = '' # カナの名前が空欄なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'お名前カナ(名字)は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = '漢字' # カナの名字が漢字なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'お名前カナ(名前)は、全角（漢字・ひらがな・カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = '漢字' # カナの名前が漢字なら、「異常になる＝緑」
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end

      it '生年月日を入力しないと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
