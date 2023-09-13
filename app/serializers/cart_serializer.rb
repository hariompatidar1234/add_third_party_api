class CartSerializer < ActiveModel::Serializer
  attributes :id,:dish_id,:quantity,:total_amount
  attributes :id , :user_id

  has_many :cart_items
  has_many :dishes
  belongs_to :user
end
