class MessageSerializer < ActiveModel::Serializer
  attributes :id, :text, :sender, :receiver, :created_at

  def created_at
    object.created_at.strftime('%y-%-m-%-d %H:%M')
  end
end
