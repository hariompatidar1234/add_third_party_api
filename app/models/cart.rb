class Cart < ApplicationRecord
  belongs_to :user

  has_many :cart_items
  has_many :dishes, through: :cart_items

 
end 
