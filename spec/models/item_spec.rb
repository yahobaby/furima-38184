# % bundle exec rspec spec/models/item_spec.rb

require 'rails_helper'

RSpec.describe Item, type: :model do
  before do # Itemのインスタンス生成 /spec/factories/items.rb+共通記述を切り出す
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品出品ができるとき' do # OK
      it '全て正しく入力されると、登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品出品ができないとき' do
      it '商品画像が空では登録されない' do # OK
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が空では登録されない' do # OK
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it '商品説明が空では登録されない' do # OK
        @item.item_explain = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item explain can't be blank")
      end

      it 'カテゴリーが空では登録されない' do # OK
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品状態が空では登録されない' do # OK
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item status can't be blank")
      end

      it '配送料の負担の情報が空では登録されない' do # OK
        @item.charge_bearer_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge bearer can't be blank")
      end

      it '発送元の地域の情報が空では登録されない' do # OK
        @item.sending_area_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Sending area can't be blank")
      end

      it '発送までの日数の情報が空では登録されない' do # OK
        @item.delivery_days_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery days can't be blank")
      end

      it 'カテゴリー、商品状態、配送料の負担、発送元の地域、発送までの日数のidが1で選択された場合は登録されない' do
        @item.category_id = '1'
        @item.item_status_id = '1'
        @item.charge_bearer_id = '1'
        @item.sending_area_id = '1'
        @item.delivery_days_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1', 'Item status must be other than 1',
                                                      'Charge bearer must be other than 1', 'Sending area must be other than 1', 'Delivery days must be other than 1')
      end

      # 価格関連テスト
      it '価額が空では登録されない' do # OK
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価額が300より小さいと登録されない' do # OK
        @item.price = '77'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than 300')
      end

      it '価額が9999999より大きいと登録されない' do # OK
        @item.price = '77777777'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than 9999999')
      end

      it 'priceが半角数字以外では登録できない' do # OK
        @item.price = '７７７７７'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      # //価格関連テスト
    end
  end
end
