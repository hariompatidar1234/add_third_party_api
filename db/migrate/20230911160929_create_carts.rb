class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.string :status
      t.decimal :total_amounts
      t.integer :quantity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
