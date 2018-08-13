require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer

  attr_reader :number, :free

  def initialize(number)
    @number = number
    @free = true
  end
  def change_state
    @free = !free
  end
end
