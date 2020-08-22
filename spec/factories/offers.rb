FactoryBot.define do
  factory :offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    premium { false }
    starts_at { 1.day.ago }
    ends_at { nil }
    description { Faker::Lorem.characters(number: 50) }
  end

  factory :offer_enabled, class: Offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    premium { false }
    starts_at { Date.today }
    ends_at { nil }
    description { Faker::Lorem.characters(number: 50) }
    state { :enabled }
  end

  factory :offer_may_disable, class: Offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    premium { false }
    starts_at { 1.day.ago }
    ends_at { 1.day.ago }
    description { Faker::Lorem.characters(number: 50) }
    state { :enabled }
  end

  factory :offer_dont_disable, class: Offer do
    advertiser_name { Faker::Company.name }
    url { Faker::Internet.url }
    premium { false }
    starts_at { 1.day.ago }
    ends_at { nil }
    description { Faker::Lorem.characters(number: 50) }
    state { :enabled }
  end
end
