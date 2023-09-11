class Dish < ApplicationRecord
  belongs_to :category
  belongs_to :restaurant
  has_many :order_items
  has_many :orders, through: :order_items
end
