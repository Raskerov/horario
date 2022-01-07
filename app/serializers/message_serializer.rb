class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :sender, :created_at

  def created_at
    object.created_at.strftime('%y-%-m-%-d %H:%M')
  end
end
