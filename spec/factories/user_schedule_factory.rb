FactoryBot.define do
  factory :user_schedule do
    association :schedule
    association :user
  end
end
