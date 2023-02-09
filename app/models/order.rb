class Order < ApplicationRecord
  has_many :order_product_lists, dependent: :destroy
  belongs_to :discont_coupon, optional: true

  def products_cost
    cost = 0
    order_product_lists.each do |products|
      cost += products.product.unit_price * products.product_quantity
    end
    cost
  end

  def discont_value
    products_cost * discont_coupon_value
  end

  private

  def discont_coupon_value
    @discont_coupon_value ||= discont_coupon&.still_valid ? discont_coupon.discont : 0
  end
end
