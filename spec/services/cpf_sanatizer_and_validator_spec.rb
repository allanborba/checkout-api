require 'rails_helper'

describe CpfSanatizerAndValidator do
  let(:cpf) { described_class.new(cpf_value).perform }

  describe "#validate" do
    context "when the cpf does not have 11 numbers" do
      let(:cpf_value) {"abc.123.123-50"}

      it { expect { cpf }.to raise_error(ArgumentError, "CPF invalid") }
    end

    context "when all cpf numbers are equal" do
      let(:cpf_value) { "00000000000" }

      it { expect { cpf }.to raise_error(ArgumentError, "CPF invalid") }
    end

    context "when is not a valid number" do
      let(:cpf_value) { "123.456.789-10" }

      it { expect { cpf }.to raise_error(ArgumentError, "CPF invalid") }
    end

    context "when is not a valid number" do
      let(:cpf_value) { "208.872.250-55" }

      it { expect(cpf).to eq("20887225055") }
    end
  end
end
