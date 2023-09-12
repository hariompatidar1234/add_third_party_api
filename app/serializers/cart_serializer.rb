class CartSerializer < ActiveModel::Serializer
  attributes :id,:dish_id,:quantity,:total_amount
end
