class Order < ApplicationRecord
  belongs_to :customer, foreign_key: 'user_id'

  has_many :order_items, dependent: :destroy
  has_many :dishes, through: :order_items
  validates :address, presence: true
    # validates_presence_of  :razorpay_order_id, :razorpay_signature

    enum :payment_status, {
       payment_pending: "payment_pending",
       payment_confirmed: "payment_confirmed"
     }
end
