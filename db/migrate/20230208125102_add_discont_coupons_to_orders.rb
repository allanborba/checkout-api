class AddDiscontCouponsToOrders < ActiveRecord::Migration[7.0]
  def change
    change_table :orders do |t|
      t.references :discont_coupon, null: true
    end
  end
end
