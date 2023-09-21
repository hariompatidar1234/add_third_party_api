class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :type, :created_at
end
