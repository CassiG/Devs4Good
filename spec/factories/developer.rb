require 'faker'

FactoryGirl.define do
  factory :developer, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_type { 'dev' }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    website { Faker::Internet.domain_name }
    description { Faker::StarWars.quote }
    phone { Faker::PhoneNumber.cell_phone }
  end
end
