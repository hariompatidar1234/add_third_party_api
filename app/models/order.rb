class Order < ApplicationRecord
  belongs_to :user

  has_many :order_items
  has_many :dishes, through: :order_items
  
  before_validation :set_default_order_status

  private

  def set_default_order_status
    self.order_status ||= "ordered"
  end
end
