class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :address

  has_many :order_items
end
