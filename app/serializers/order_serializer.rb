class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_many :order_items
end
