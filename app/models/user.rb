class User < ApplicationRecord
  extend Devise::Models

  # Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable

  belongs_to :company
  has_many :received_messages, class_name: 'Message', foreign_key: :receiver_id
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id

  enum role: { owner: 1, manager: 2, worker: 3 }

  validates_uniqueness_of :email
end
