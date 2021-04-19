FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    image { "" }
    price { Faker::Number.between(from: 1, to: 10000) }
    purchase_date { Faker::Date.between(from: 5.years.ago, to: Date.today) }

    user
  end
end
