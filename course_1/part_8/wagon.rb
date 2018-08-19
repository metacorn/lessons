require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer
  include Validity

  attr_reader :number
  attr_accessor :free

  def initialize(number, *auxiliary)
    @number = number.to_s
    self.free = true
    validate!
  end

  def change_state
    self.free = !free
  end

  private

  WAGON_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы

  def validate!
    raise "Wagon number can't be nil!" if number.nil?
    raise "Wagon number should conform to the established mask!" if number !~ WAGON_NUMBER_PATTERN
  end
end
