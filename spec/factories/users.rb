FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :admin_user, class: User do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    role { :admin }
  end
end
