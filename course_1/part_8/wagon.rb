require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer
  include Validity

  attr_reader :number, :type, :capacity, :free, :free_space

  def initialize(number, type, capacity)
    @number = number
    @type = type
    @capacity = capacity
    @free_space = capacity
    @free = true
    validate!
  end

  def change_state
    @free = !free
  end

  def take_space(space)
    @free_space -= space
  end

  def filled_space
    capacity - free_space
  end

  private

  WAGON_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы

  def validate!
    raise "Wagon number can't be nil!" if number.nil?
    raise "Wagon number should conform to the established mask!" if number !~ WAGON_NUMBER_PATTERN
  end
end
