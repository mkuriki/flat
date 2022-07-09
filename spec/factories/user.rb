FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    phone_number { 12345678910 }
    password { 'password' }
    password_confirmation { 'password' }
    name { Faker::Name.name}
    introduction { Faker::Lorem.characters(number:30)}
    last_name {Faker::Lorem.characters(number:5)}
    first_name {Faker::Lorem.characters(number:5)}
    is_deleted {'false'}
  end
end