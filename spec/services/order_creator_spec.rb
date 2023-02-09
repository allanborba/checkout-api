require "rails_helper"

describe OrderCreator do
  let(:order) { described_class.new.perform(cpf, hash_products, cupon_id) }
  let(:products) do
    [create(:product, unit_price: 5), create(:product, unit_price: 10), create(:product, unit_price: 15)]
  end
  let(:hash_products) do
    {
      products[0].id => 1,
      products[1].id => 1,
      products[2].id => 3
    }
  end

  let(:discont_coupon) { create(:discont_coupon) }
  let(:cupon_id) { discont_coupon.id }
  let(:cpf) { "valid_cpf" }
  let(:cpf_sanatize_mock) { instance_double(CpfSanatizerAndValidator) }

  before do
    allow(CpfSanatizerAndValidator).to receive(:new).and_return(cpf_sanatize_mock)
    allow(cpf_sanatize_mock).to receive(:perform).and_return("valid_cpf")
  end

  describe "#perform" do
    context "when products are valid" do
      it "create an order and the order product lists" do
        expect { order }.to change(OrderProductList, :count).by(3).and change(Order, :count).by(1)
        expect(Order.last.order_product_lists.order(:id).pluck(:product_id)).to eq(products.pluck(:id))
        expect(Order.last.order_product_lists.order(:id).pluck(:product_quantity)).to eq(hash_products.values)
        expect(Order.last.discont_coupon_id).to eq(cupon_id)
        expect(cpf_sanatize_mock).to have_received(:perform).once
      end
    end

    context "when product quantities are not integers" do
      let(:hash_products) { { 1 => 1, 2 => 5, 3 => "10" } }

      it { expect { order }.to raise_error(ArgumentError, "Quantity must be a Integer") }
    end
    context "when product quantities aren't grater than one" do
      let(:hash_products) { { 1 => 1, 2 => 5, 3 => 0 } }

      it { expect { order }.to raise_error(ArgumentError, "Quantity must be greathr than one") }
    end

    context "when the product id does not exist" do
      let(:hash_products) { { products[0].id => 1, products[1].id => 1, "invalid_id" => 3 } }

      it { expect { order }.to raise_error(ArgumentError, "Non-existent product id") }
    end

    context "when the cupon id does not exist" do
      let(:cupon_id) { "1" }

      it { expect { order }.to raise_error(ArgumentError, "Non-existent cupon id") }
    end
  end
end
