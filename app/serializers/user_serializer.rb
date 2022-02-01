class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :company, :role, :joined, :managing

  def company
    object.company.name
  end

  def joined
    object.confirmed_at.present?
  end

  def managing
    object.managing?
  end
end
