require 'faker'

FactoryGirl.define do
  factory :developer, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_type { 'dev' }
    email { Faker::Internet.safe_email }
    password { 'password123' }
    password_confirmation { 'password123'}
    website { Faker::Internet.url }
    description { Faker::StarWars.quote }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
