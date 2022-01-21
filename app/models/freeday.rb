class Freeday < ApplicationRecord
  belongs_to :user
  belongs_to :accepted_by, class_name: 'User', optional: true
  belongs_to :rejected_by, class_name: 'User', optional: true

  enum reason: { vacation: 1, l4: 2, on_demand: 3, unpaid: 4 }
  enum status: { requested: 1, accepted: 2, rejected: 3 }

  validates_presence_of :user, :reason, :status, :start_date, :end_date

  def cancelled?
    rejected && rejected_by == user
  end

  def rejected?
    rejected && rejected_by != user
  end
end
