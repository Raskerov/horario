class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_hour, :end_hour, :weekdays, :user_ids

  def user_ids
    object.user_schedules.pluck(:user_id)
  end
end
