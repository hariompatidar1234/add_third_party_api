class Dish < ApplicationRecord
  belongs_to :category
  belongs_to :restaurant

  has_many :cart_items 
  has_many :cart, through: :cart_items

  has_many :order_items
  has_many :orders, through: :order_items

  has_one_attached :picture

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :restaurant_id, uniqueness: { scope: :name, message: 'dish already added ' }
end
