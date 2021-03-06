# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(first: "Administrator",
             last:  "Administrator",
             email: "admin@example.org",
             password:              "administrator",
             password_confirmation: "administrator",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

# Some sample users
99.times do |n|
  password = "password"
  User.create!(first: Faker::Name.first_name,
               last:  Faker::Name.last_name,
               email: Faker::Internet.safe_email,
               password:              password,
               password_confirmation: password,
               activated:    true,
               activated_at: Time.zone.now)
end
