class CpfSanatizerAndValidator
  attr_reader :cpf

  def initialize(cpf)
    @cpf = cpf.delete("^0-9")
  end

  def perform
    raise_cpf_error unless validate_size
    raise_cpf_error unless validate_all_numbers_equals
    raise_cpf_error unless validation_equation

    cpf
  end

  private

  def validate_size
    cpf.size == 11
  end

  def validate_all_numbers_equals
    cpf.chars.any? { |c| c != cpf[0] }
  end

  def validation_equation
    d1 = d2 = 0

    for i in 1..(cpf.size - 2) do
      digit = cpf[i - 1].to_i
      d1 += (11 - i) * digit
      d2 += (12 - i) * digit
    end

    rest = d1 % 11
    dg1 = rest < 2 ? 0 : 11 - rest

    d2 += 2 * dg1
    rest = d2 % 11
    dg2 = rest < 2 ? 0 : 11 - rest

    n_dig_verific = cpf[cpf.size - 2, cpf.size]
    n_dig_result = dg1.to_s + dg2.to_s

    n_dig_verific == n_dig_result
  end

  def raise_cpf_error
    raise ArgumentError, "CPF invalid"
  end
end