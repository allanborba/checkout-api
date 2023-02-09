require "rails_helper"

RSpec.describe Product do
  let(:product) { described_class.new(params).save }
  let(:params) { { description: description, unit_price: unit_price } }
  let(:description) { "Item description" }
  let(:unit_price) { 5.0 }

  describe "#validate" do
    context "when description is invalid" do
      let(:description) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Description must be a String") }
    end

    context "when unit price is invalid" do
      let(:unit_price) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Unit price must be a Float") }
    end

    context "when unit price is not a valid number" do
      let(:unit_price) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Unit price must be greater then zero") }
    end

    context "when has valid params" do
      it { expect { product }.to change(Product, :count).by(1) }
    end
  end
end
