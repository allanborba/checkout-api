require "rails_helper"

RSpec.describe Product do
  let(:product) { described_class.new(params).save }
  let(:params) do
    {
      description: description,
      unit_price: unit_price,
      width: width,
      height: height,
      depth: depth,
      weight: weight
    }
  end
  let(:description) { "Item description" }
  let(:unit_price) { 5.0 }
  let(:width) { 1 }
  let(:height) { 1.0 }
  let(:depth) { 1.0 }
  let(:weight) { 1.0 }

  describe "#validate" do
    context "when description is invalid" do
      let(:description) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Description must be a String") }
    end

    context "when unit price is invalid" do
      let(:unit_price) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Unit price must be a Float") }
    end

    context "when width is invalid" do
      let(:width) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Width must be a Float") }
    end
    context "when height is invalid" do
      let(:height) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Height must be a Float") }
    end
    context "when depth, is invalid" do
      let(:depth) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Depth must be a Float") }
    end
    context "when weight, is invalid" do
      let(:weight) { nil }

      it { expect { product }.to raise_error(ArgumentError, "Weight must be a Float") }
    end

    context "when unit price is not a valid number" do
      let(:unit_price) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Unit price must be greater then zero") }
    end

    context "when width is not a valid number" do
      let(:width) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Width must be greater then zero") }
    end
    context "when height is not a valid number" do
      let(:height) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Height must be greater then zero") }
    end
    context "when depth is not a valid number" do
      let(:depth) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Depth must be greater then zero") }
    end
    context "when weight is not a valid number" do
      let(:weight) { -1.0 }

      it { expect { product }.to raise_error(ArgumentError, "Weight must be greater then zero") }
    end

    context "when has valid params" do
      it { expect { product }.to change(Product, :count).by(1) }
    end
  end
end
