class CreateDiscontCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :discont_coupons do |t|
      t.boolean :still_valid, default: true
      t.float :discont, null: false, default: 0
      t.string :name, null: false

      t.timestamps
    end
  end
end
