class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :company, :role

  def company
    object.company.name
  end

  # TODO: User status
end
