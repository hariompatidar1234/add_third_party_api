class CreateCartItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_items do |t|
      t.decimal :total_amounts
      t.integer :quantity
      t.references :cart, foreign_key: true
      t.references :dish, foreign_key: true

      t.timestamps
    end
  end
end
