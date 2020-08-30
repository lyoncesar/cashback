# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
10.times do |n|
  Offer.create(
    advertiser_name: Faker::Company.name,
    url: Faker::Internet.url,
    premium: false,
    starts_at: 1.day.ago,
    description: Faker::Lorem.characters(number: 50)
  )
end

5.times do |n|
  Offer.create(
    advertiser_name: Faker::Company.name,
    url: Faker::Internet.url,
    premium: false,
    starts_at: Date.today,
    description: Faker::Lorem.characters(number: 50),
    state: :enabled
  )
end

5.times do |n|
  Offer.create(
    advertiser_name: Faker::Company.name,
    url: Faker::Internet.url,
    premium: true,
    starts_at: 1.day.ago,
    ends_at: 0.day.from_now,
    description: Faker::Lorem.characters(number: 50),
    state: :enabled
  )
end
