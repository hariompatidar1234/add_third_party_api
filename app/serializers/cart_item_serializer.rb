class CartItemSerializer < ActiveModel::Serializer
  attributes :id, :total_amount,:dish_id,:quantity

  belongs_to :dish
  belongs_to :cart
end
