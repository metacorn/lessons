require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer
  include Validity

  attr_reader :number, :free

  def initialize(number)
    @number = number
    @free = true
    validate!
  end

  def change_state
    @free = !free
  end

  private

  WAGON_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы

  def validate!
    raise "Wagon number can't be nil!" if number.nil?
    raise "Wagon number should conform to the established mask!" if number !~ WAGON_NUMBER_PATTERN
  end
end
