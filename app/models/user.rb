class User < ApplicationRecord
  extend Devise::Models

  # Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable

  belongs_to :company
  has_many :received_messages, class_name: 'Message', foreign_key: :receiver_id, dependent: :delete_all
  has_many :sent_messages, class_name: 'Message', foreign_key: :sender_id, dependent: :delete_all
  has_many :user_schedules, dependent: :delete_all
  has_many :schedules, through: :user_schedules
  has_many :freedays, dependent: :delete_all
  has_many :accepted_freedays, class_name: 'Freeday', foreign_key: :accepted_by
  has_many :rejected_freedays, class_name: 'Freeday', foreign_key: :rejected_by

  enum role: { owner: 1, manager: 2, worker: 3 }

  validates_uniqueness_of :email

  def managing?
    owner? || manager?
  end

  def send_confirmation_notification?
    false
  end
end
