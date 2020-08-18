FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    premium { false }
    starts_at { Time.zone.now }
    ends_at { nil }
    description { Faker::Lorem.characters(number: 50) }
  end
end
