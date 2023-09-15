class Cart < ApplicationRecord
  belongs_to :customer ,foreign_key: 'user_id'

  has_many :cart_items
  has_many :dishes, through: :cart_items
end
