FactoryBot.define do
  factory :schedule do
    association :company
    sequence(:name, 1000) { |n| "Schedule #{n}" }
    start_hour { '08:00' }
    end_hour { '16:00' }
    weekdays { %w[monday tuesday wednesday thursday friday]}

    trait :second_shift do
      start_hour { '14:00' }
      end_hour { '22:00' }
    end
  end
end
