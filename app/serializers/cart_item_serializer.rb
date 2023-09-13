class CartItemSerializer < ActiveModel::Serializer
  attributes :id,:total_amount

  has_many :dishes
end
