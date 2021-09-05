class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :company

  def company
    object.company.name
  end
end
