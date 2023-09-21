class CartSerializer < ActiveModel::Serializer
  attributes :id, :user_id

  has_many :cart_items
  has_many :dishes, through: :cart_items
  belongs_to :customer
end
