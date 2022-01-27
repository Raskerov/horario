FactoryBot.define do
  factory :freeday do
    association  :user
    status { 1 }
    reason { 1 }
    start_date { Time.now.advance(days: -1) }
    end_date { Time.now.advance(weeks: 1) }
  end
end
