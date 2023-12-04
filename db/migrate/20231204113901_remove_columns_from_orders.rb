class RemoveColumnsFromOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :orders, :razorpay_order_id, :string
    remove_column :orders, :razorpay_signature, :string
    remove_column :orders, :razorpay_payment_id, :string
  end
end
