class AddSerialNumberToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :serial_number, :string, null: false
  end
end
