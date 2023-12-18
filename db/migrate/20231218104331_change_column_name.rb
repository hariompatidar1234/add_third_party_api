class ChangeColumnName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :contact, :phone_number
  end
end
