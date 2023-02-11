require "rails_helper"

RSpec.describe Order do
  let!(:products) { [create_product(5), create_product(10), create_product(15)] }

  let(:cupon_id) { nil }
  let(:cpf) { "208.872.250-55" }
  let(:order) { described_class.create(cpf: cpf, discont_coupon_id: cupon_id) }

  before do
    [
      create(:order_product_list, product: products[0], product_quantity: 1, order_id: order.id),
      create(:order_product_list, product: products[1], product_quantity: 1, order_id: order.id),
      create(:order_product_list, product: products[2], product_quantity: 3, order_id: order.id)
    ]
  end

  describe "#products_cost" do
    it { expect(order.products_cost).to eq(60) }
  end

  describe "#discont_value" do
    context "when there is no discount coupon" do
      it { expect(order.discont_value).to eq(0) }
    end

    context "when discount coupon is invalid" do
      let(:discont_coupon) { create(:discont_coupon, still_valid: false) }
      let(:cupon_id) { discont_coupon.id }

      it { expect(order.discont_value).to eq(0) }
    end

    context "when discount coupon is valid" do
      let(:discont_coupon) { create(:discont_coupon, still_valid: true, discont: 0.4) }
      let(:cupon_id) { discont_coupon.id }

      it { expect(order.discont_value).to eq(60 * 0.4) }
    end
  end

  describe "#freight_cost" do
    context "when the freight value is not minimum" do
      let(:delivery_distance) { 1000 }
      let(:products_volume) { 1 * 0.2 * 0.1 } # widht * height * depth
      let(:products_density) { 10 / products_volume } # weight / volume
      let(:result) { 5 * products_volume * products_density / 100 * delivery_distance } # number_of_products * freight formula

      it { expect(order.freight_cost(delivery_distance)).to eq(result) }
    end
  end
end

def create_product(unit_price = 5)
  create(
    :product,
    unit_price: unit_price,
    width: 1.0,
    height: 0.2,
    depth: 0.1,
    weight: 10
  )
end
