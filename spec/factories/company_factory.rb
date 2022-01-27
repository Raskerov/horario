FactoryBot.define do
  factory :company do
    sequence(:name) { |n| "Some company #{n}" }
  end
end
