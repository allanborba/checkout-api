require "rails_helper"

RSpec.describe Order do
  let!(:products) do
    [create(:product, unit_price: 5), create(:product, unit_price: 10), create(:product, unit_price: 15)]
  end

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
end
