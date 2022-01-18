class UserSchedule < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :schedule, dependent: :destroy
end
