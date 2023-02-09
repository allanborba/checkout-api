class Product < ApplicationRecord
  before_save :validate_arguments
  before_update :validate_arguments

  private

  def validate_arguments
    validate_type

    raise ArgumentError, "Unit price must be greater then zero" unless unit_price > 0.0
    raise ArgumentError, "Width must be greater then zero" unless width > 0.0
    raise ArgumentError, "Height must be greater then zero" unless height > 0.0
    raise ArgumentError, "Depth must be greater then zero" unless depth > 0.0
    raise ArgumentError, "Weight must be greater then zero" unless weight > 0.0
  end

  def validate_type
    raise ArgumentError, "Description must be a String" unless description.is_a? String
    raise ArgumentError, "Unit price must be a Float" unless unit_price.is_a? Float
    raise ArgumentError, "Width must be a Float" unless width.is_a? Float
    raise ArgumentError, "Height must be a Float" unless height.is_a? Float
    raise ArgumentError, "Depth must be a Float" unless depth.is_a? Float
    raise ArgumentError, "Weight must be a Float" unless weight.is_a? Float
  end
end
