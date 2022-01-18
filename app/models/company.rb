class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :schedules, dependent: :destroy

  validates_presence_of :name
end
