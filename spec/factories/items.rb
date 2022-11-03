FactoryBot.define do
  factory :item do
    item_name               { Faker::Name.initials }
    item_explain            { Faker::Lorem.sentence }
    category_id             { '11' }
    item_status_id          { '7' }
    charge_bearer_id        { '3' }
    sending_area_id         { '48' }
    delivery_days_id        { '4' }
    price                   { '5000' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/testimage.jpeg'), filename: 'testimage.jpeg')
    end
  end
end
