class FreightCostCalculator
  attr_reader :distance, :density, :volume

  MINIMUM_FREIGHT_COST = 10.0

  def initialize(distance, density, volume)
    @distance = distance
    @density = density
    @volume = volume

    validate_arguments
  end

  def perform
    [distance * volume * density / 100, MINIMUM_FREIGHT_COST].max
  end

  private

  def validate_arguments
    validate_type
    raise ArgumentError, "Distance must be greater than zero" unless distance > 0
    raise ArgumentError, "Density must be greater than zero" unless density > 0
    raise ArgumentError, "Volume must be greater than zero" unless volume > 0
  end

  def validate_type
    raise ArgumentError, "Distance must be a Integer" unless distance.is_a? Integer
    raise ArgumentError, "Density must be a Float" unless density.is_a? Float
    raise ArgumentError, "Volume must be a Float" unless volume.is_a? Float
  end
end
