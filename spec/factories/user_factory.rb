FactoryBot.define do
  factory :user do
    sequence(:full_name, 1000) { |n| "John Doe #{n}" }
    sequence(:email, 1000) { |n| "test_#{n}@example.com" }
    password { "Aa1#{SecureRandom.hex}" }
    confirmed_at { Time.now }
    association :company
    role { 1 }
    admin { false }
    confirmation_token { SecureRandom.hex }

    trait :unconfirmed do
      confirmed_at { nil }
    end

    trait :admin do
      admin { true }
    end

    trait :manager do
      role { 2 }
    end

    trait :worker do
      role { 3 }
    end
  end
end
