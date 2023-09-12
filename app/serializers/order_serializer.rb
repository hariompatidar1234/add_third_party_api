class OrderSerializer < ActiveModel::Serializer
  attributes :id 

  has_many :order_items, serializer: OrderitemsSerializer
end
