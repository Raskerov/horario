class FreedaySerializer < ActiveModel::Serializer
  attributes :id, :user, :dates, :status, :status_label, :reason

  def dates
    "#{object.start_date.strftime('%d.%m.%Y')} - #{object.end_date.strftime('%d.%m.%Y')}"
  end

  def user
    object.user.slice(:id, :full_name)
  end

  def status_label
    return object.status unless object.rejected?

    object.cancelled? ? 'cancelled' : 'rejected'
  end
end
