FactoryBot.define do 
  factory :post do
    association :user, factory: :user
    title{ Faker::Lorem.characters(number:10)  }
    body { Faker::Lorem.characters(number:30) }
    date {'2020/10/01'}
  end
end