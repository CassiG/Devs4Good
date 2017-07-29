# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Project.delete_all

10.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    user_type: 'dev',
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password,
    website: Faker::Internet.url,
    description: Faker::StarWars.quote,
    phone: Faker::PhoneNumber.cell_phone
    )
end

10.times do
  User.create(
    org_name: Faker::Company.name,
    street_address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip: Faker::Address.zip,
    user_type: 'org',
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password,
    website: Faker::Internet.url,
    description: Faker::StarWars.quote,
    phone: Faker::PhoneNumber.cell_phone
  )
end

10.times do
  Project.create(organization_id: User.where(user_type: 'org').sample.id, description: Faker::Hipster.paragraph, time_frame: Faker::Date.forward(30), title: Faker::HarryPotter.quote)
end
