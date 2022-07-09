FactoryBot.define do
  factory :group do
    association :post, factory: :post
    name { Faker::Lorem.characters(number:10) }
    introduction{ Faker::Lorem.characters(number:20) }
  end
end