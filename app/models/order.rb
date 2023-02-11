class Order < ApplicationRecord
  has_many :order_product_lists, dependent: :destroy
  belongs_to :discont_coupon, optional: true

  def products_cost
    @products_cost ||= order_product_lists.reduce(0) do |cost, list|
      cost + (list.product.unit_price * list.product_quantity)
    end
  end

  def discont_value
    products_cost * discont_coupon_value
  end

  def freight_cost(delivery_distance)
    @freight_cost ||= order_product_lists.reduce(0) do |cost, list|
      cost + product_freight_calculator(list, delivery_distance)
    end
  end

  private

  def discont_coupon_value
    @discont_coupon_value ||= discont_coupon&.still_valid? ? discont_coupon.discont : 0
  end

  def product_freight_calculator(list, delivery_distance)
    volume = list.product.width * list.product.height * list.product.depth
    density = list.product.weight / volume
    list.product_quantity * FreightCostCalculator.new(delivery_distance, density, volume).perform
  end
end
