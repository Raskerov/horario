FactoryBot.define do
  factory :message do
    association :sender, factory: :user
    association :receiver, factory: :user
    text { 'Message text' }
  end
end
