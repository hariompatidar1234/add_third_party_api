class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :dish_name, :dish_price

  belongs_to :order
end
