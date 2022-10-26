FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    # nickname              {'tech'}
    # email                 {'tech@camp'}
    password              { 'hello000000' }
    password_confirmation { password }
    last_name_kana        { 'カタカナ' }
    first_name_kana       { 'カタカナ' }
    last_name_kanji       { '漢字' }
    first_name_kanji      { '漢字' }
    birthday              { Faker::Date.between_except(from: 1.year.ago, to: 1.year.from_now, excepted: Date.today) }
    # birthday              {'1931-09-04'}
  end
end
