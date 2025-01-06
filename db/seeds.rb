# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Location.destroy_all
User.destroy_all

require 'faker'


puts "Start create users and locations"
# Create a user with faker
10.times do
  User.create(
    email: Faker::Internet.email,
    password: "password"
  )
end

puts "Finish create users"

User.create(email: "admin@admin.com", password: "password")
Location.create(address: "17 rue Alphonse Karr, Nice",
                title: "Les sylphes",
                description: "Un appartement de rêve",
                price: 100,
                user_id: User.last.id)

2.times do
  users = User.all
  users.each do |user|
    Location.create(
      address: Faker::Address.full_address,
      description: Faker::Lorem.paragraph,
      title: Faker::Lorem.sentence,
      price: Faker::Number.decimal(l_digits: 2),
      user_id: user.id
    )
  end
end

puts "Finish create locations"
