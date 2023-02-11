require "rails_helper"

describe SerialNumberCreator do
  let(:serial_number_creator) { described_class.new(last_serial) }

  describe "#new" do
    context "when last_serial is not a string" do
      let(:last_serial) { nil }

      it { expect { serial_number_creator }.to raise_error(ArgumentError, "Last serial must be a String") }
    end

    context "when last_serial not contain 12 chars" do
      let(:last_serial) { "AAA123456789" }

      it do
        expect { serial_number_creator }.to raise_error(
          ArgumentError, "Last serial must contain only 12 chars numberics"
        )
      end
    end
    context "when the last serial does not have a valid year" do
      let(:last_serial) { "210123456789" }

      it { expect { serial_number_creator }.to raise_error(ArgumentError, "Invalid year") }
    end

  end

  describe "#perform" do
    context "when the last serial number is not from this year" do
      let(:last_serial) { "202200000008" }

      it { expect(serial_number_creator.perform).to eq("202300000001") }
    end
    context "when the last serial number is from this year" do
      let(:last_serial) { "202300000009" }

      it { expect(serial_number_creator.perform).to eq("202300000010") }
    end
    context "when the last serial number is a large number" do
      let(:last_serial) { "202399999989" }

      it { expect(serial_number_creator.perform).to eq("202399999990") }
    end
  end
end
