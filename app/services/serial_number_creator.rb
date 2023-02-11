class SerialNumberCreator
  attr_reader :last_serial_number

  def initialize(last_serial_number)
    @last_serial_number = last_serial_number&.delete("^0-9")
    validate_arguments
  end

  def perform
    return "#{Date.today.year}00000001" unless same_year?

    (last_serial_number.to_i + 1).to_s
  end

  private

  def validate_arguments
    raise ArgumentError, "Last serial must be a String" unless last_serial_number.is_a? String
    raise ArgumentError, "Last serial must contain only 12 chars numberics" unless last_serial_number.size == 12
    raise ArgumentError, "Invalid year" unless last_serial_number[0, 2] == "20"
  end

  def same_year?
    last_serial_number[0, 4] == Date.today.year.to_s
  end
end
