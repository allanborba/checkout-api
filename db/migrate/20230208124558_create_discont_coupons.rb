class CreateDiscontCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :discont_coupons do |t|
      t.date :expiration_date, null: false
      t.float :discont, null: false, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end
