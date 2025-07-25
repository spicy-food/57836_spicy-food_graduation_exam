FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password123' }
    password_confirmation { 'password123' }
    name { Faker::Name.name }

    trait :admin do
      email { 'guuuuumi93@gmail.com' }
    end
  end
end