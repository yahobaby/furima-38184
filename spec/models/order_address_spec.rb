# 「学習メモ」テストコード実行：%bundle exec rspec spec/models/order_address_spec.rb

require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    # 下記のようなエラーが発生。
    # 先に読み込まれるものが無いようにして、0.05秒毎にテスト処理を行うようsleep(0.05)を追記し、エラー回避してます。
    # Showing full backtrace because every line was filtered out.
    # See docs for RSpec::Configuration#backtrace_exclusion_patterns and
    # RSpec::Configuration#backtrace_inclusion_patterns for more information.
    # Mysql2::Error:
    # MySQL client is not connected
    # /Users/taehwankim/.rbenv/versions/2.6.5/lib/ruby/gems/2.6.0/gems/mysql2-0.5.4/lib/mysql2/client.rb:148:in `_query'
    user = FactoryBot.create(:user)
    # sleep(0.05)
    item = FactoryBot.create(:item)
    # sleep(0.05)
    @order_address = FactoryBot.build(:order_address, item_id: item.id, user_id: user.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end
      it 'user_idが空でないと保存できる' do
        @order_address.user_id = 1
        expect(@order_address).to be_valid
      end
      it 'item_idが空でないと保存できる' do
        @order_address.item_id = 1
        expect(@order_address).to be_valid
      end
      it '郵便番号が「3桁+ハイフン+4桁」の組み合わせであれば保存できる' do
        @order_address.post_code = '777-7777'
        expect(@order_address).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @order_address.prefecture_id = 1
        expect(@order_address).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @order_address.city = '沖縄市'
        expect(@order_address).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @order_address.address = '西区7丁目7'
        expect(@order_address).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_address.building_name = ' '
        expect(@order_address).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @order_address.phone_number = 77_777_777_777
        expect(@order_address).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空なら保存できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空なら保存できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空なら保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号にハイフンがなかったら保存できない' do
        @order_address.post_code = 7_777_777
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」なら保存できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空なら保存できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空なら保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空なら保存できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空なら保存できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあるなら保存できない' do
        @order_address.phone_number = '777-7777-7777'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あるなら保存できない' do
        @order_address.phone_number = 12_345_678_910_123_456_789
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以下あるなら保存できない' do
        @order_address.phone_number = 12_345
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空なら保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
