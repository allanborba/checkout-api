class Product < ApplicationRecord
  before_save :validate_arguments
  before_update :validate_arguments

  def validate_arguments
    raise ArgumentError, "Description must be a String" unless description.is_a? String
    raise ArgumentError, "Unit price must be a Float" unless unit_price.is_a? Float
    raise ArgumentError, "Unit price must be greater then zero" unless unit_price > 0.0
  end
end
