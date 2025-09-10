FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Test User #{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password123" }
    password_confirmation { "password123" }
    
    # セキュリティ質問フィールドを追加
    security_question { "birthplace" }
    security_answer { "Tokyo" }

    trait :admin do
      email { "guuuuumi93@gmail.com" }
      security_question { "birthplace" }
      security_answer { "Tokyo" }
    end
  end
end