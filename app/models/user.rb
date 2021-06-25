class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :company_users, dependent: :destroy
  has_many :companies, through: :company_users

  validates_presence_of :first_name, :last_name, :email

  enum role: { owner: 1, manager: 2, worker: 3 }
end
