FactoryBot.define do
  factory :favorite do
    association :post, factory: :post
    association :user, factory: :user
  end
end