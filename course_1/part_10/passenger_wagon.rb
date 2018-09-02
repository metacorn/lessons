class PassengerWagon < Wagon
  def initialize(number, capacity)
    super(number, 'Passenger', capacity)
  end

  def take_space
    super(1)
  end
end
