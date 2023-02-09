class AddDimensionsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :width, :float, null: false
    add_column :products, :height, :float, null: false
    add_column :products, :depth, :float, null: false
    add_column :products, :weight, :float, null: false
  end
end
