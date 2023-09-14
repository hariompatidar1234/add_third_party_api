class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.decimal :total_amount
      t.references :order, foreign_key: true
      t.references :dish, foreign_key: true
      t.integer :quantity, null: false
      t.timestamps
    end
  end
end
