FactoryBot.define do
  factory :coffee_record do
    association :user
    origin { Faker::Address.country }
    bean_type { %w[アラビカ ロブスタ リベリカ].sample }
    process_method { %w[ウォッシュド ナチュラル ハニー].sample }
    roast_level { CoffeeRecord::ROAST_LEVELS.sample }
    acidity_level { %w[低 中低 中 中高 高].sample }
    body_level { %w[軽い 中軽 中 中重 重い].sample }
    notes { Faker::Lorem.paragraph }
  end
end
