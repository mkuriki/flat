FactoryBot.define do
  factory :group_users do
    association :user, factory: :user
    association :group, factory: :group
  end
end