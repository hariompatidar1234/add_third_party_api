class AddRazorpayPaymentIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :razorpay_payment_id, :string
  end
end
