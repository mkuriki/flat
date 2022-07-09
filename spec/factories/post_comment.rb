FactoryBot.define do
  factory :post_comment do
    association :user, factory: :user
    association :post, factory: :post
    comment { Faker::Lorem.characters(number:10) }
  end
end