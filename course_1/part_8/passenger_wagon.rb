class PassengerWagon < Wagon
  attr_reader :number, :type, :capacity
  def initialize(number, capacity)
    @type = "Passenger"
    super(number, type, capacity)
  end

  def take_space
    space = 1
    super(space)
  end
end
