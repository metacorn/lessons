require_relative 'manufacturer.rb'
require_relative 'validation.rb'

class Wagon
  include Manufacturer
  include Validation

  WAGON_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9][a-zA-Zа-яА-Я0-9 -]*[a-zA-Zа-яА-Я0-9]+$/

  attr_reader :number, :type, :capacity, :free, :free_space
  validate :number, :presence
  validate :number, :format, WAGON_NUMBER_PATTERN

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
    if free_space >= space
      @free_space -= space
    else
      false
    end
  end

  def filled_space
    capacity - free_space
  end
end
