class Schedule < ApplicationRecord
  belongs_to :company
  has_many :user_schedules, dependent: :delete_all
  has_many :users, through: :user_schedules
end
