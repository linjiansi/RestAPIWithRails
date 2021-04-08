FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    image { Faker::Internet.url(host: 'i.imgur.com') }
    price { Faker::Number.between(from: 1, to: 10000) }
    purchase_date { Faker::Date.from 5.yaer.ago, to: Date.today }
  end
end
