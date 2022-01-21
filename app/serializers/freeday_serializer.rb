class FreedaySerializer < ActiveModel::Serializer
  attributes :id, :user, :dates, :status, :status_label, :reason

  def dates
    "#{object.start_date.strftime('%Y.%m.%d')} - #{object.end_date.strftime('%Y.%m.%d')}"
  end

  def user
    object.user.slice(:id, :full_name)
  end

  def status_label
    return object.status unless object.rejected?

    object.cancelled? ? 'cancelled' : 'rejected'
  end
end
