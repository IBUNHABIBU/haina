# spec/factories/users.rb
FactoryBot.define do
  factory :user do
   first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.unique.email }
    password   { "password123" }
    role       { "user" }

    trait :admin do
      role { :admin }
    end

    trait :with_profile do
      after(:create) do |user|
        create(:profile, user: user)
      end
    end
  end
end
