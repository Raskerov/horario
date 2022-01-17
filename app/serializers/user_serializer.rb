class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :company, :role, :joined

  def company
    object.company.name
  end

  def joined
    object.confirmed_at.present?
  end

  # TODO: User status
end
