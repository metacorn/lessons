require_relative 'manufacturer.rb'

class Wagon
  include Manufacturer
  include Validity

  attr_reader :number, :free

  def initialize(number)
    @number = number
    @free = true
    $validator.check_out!(self)
  end

  def change_state
    @free = !free
  end
end
