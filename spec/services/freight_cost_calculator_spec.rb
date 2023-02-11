require 'rails_helper'

describe FreightCostCalculator do
  let(:freight_calculator) { described_class.new(distance, density, volume) }
  let(:freight_cost) { freight_calculator.perform}
  let(:distance) { 1000 }
  let(:density) { 100.0 }
  let(:volume) { 0.03 }

  describe "#new" do
    context "when the distance is not a integer" do
      let(:distance) { nil }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Distance must be a Integer") }
    end
    context "when the density is not a Float" do
      let(:density) { nil }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Density must be a Float") }
    end
    context "when the volume is not a Float" do
      let(:volume) { nil }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Volume must be a Float") }
    end
    context "when distance is a invalid integer" do
      let(:distance) { 0 }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Distance must be greater than zero") }
    end
    context "when density is a invalid float" do
      let(:density) { 0.0 }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Density must be greater than zero") }
    end
    context "when density is a invalid float" do
      let(:volume) { 0.0 }

      it { expect { freight_calculator }.to raise_error(ArgumentError, "Volume must be greater than zero") }
    end
  end

  describe "#perform" do
    context "when the freight amount is less than the minimum" do
      let(:volume) { 0.01 }

      it { expect(freight_cost).to eq(FreightCostCalculator::MINIMUM_FREIGHT_COST) }
    end
    context "when the freight amount is less than the minimum" do
      it { expect(freight_cost).to eq(30) }
    end
  end
end
