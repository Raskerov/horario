class Company < ApplicationRecord
  has_many :company_users, dependent: :destroy
  has_many :users, through: :company_users

  validates_presence_of :name
end
