class Wagon
  attr_reader :number, :free

  include Manufacturer

  def initialize(number)
    @number = number
    @free = true
  end
  def change_state
    @free = !free
  end
end
