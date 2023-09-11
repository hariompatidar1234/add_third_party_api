class Cart < ApplicationRecord
  belongs_to :user
  has_many :dishes, through: :cart_items
  attribute :status, :string, default: 'cart'
  before_save :calculate_total_amount

  # ...

  private
  def calculate_total_amount
    self.total_amounts = cart_items.includes(:dish).sum { |cart_item| cart_item.dish.price * cart_item.quantity }
  end
  attribute :cart_amount, :decimal, precision: 10, scale: 2, default: 0.0
end
