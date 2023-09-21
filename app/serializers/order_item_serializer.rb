class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :dish_name, :dish_price, :total_amount

  belongs_to :order

  def dish_name
    object.dish.name
  end

  def dish_price
    object.dish.price
  end
end
