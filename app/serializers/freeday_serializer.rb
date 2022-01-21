class FreedaySerializer < ActiveModel::Serializer
  attributes :id, :user, :dates, :status, :reason

  def dates
    "#{object.start_date} - #{object.end_date}"
  end
end
