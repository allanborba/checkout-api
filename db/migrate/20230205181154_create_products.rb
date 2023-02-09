class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :description, null: false
      t.float :unit_price, null: false
      t.timestamps
    end

    create_table :orders do |t|
      t.string :cpf, null: false
      t.timestamps
    end

    create_table :order_product_lists do |t|
      t.belongs_to :order, null: false
      t.belongs_to :product, null: false
      t.integer :product_quantity, null: false, default: 1
      t.timestamps
    end
  end
end
