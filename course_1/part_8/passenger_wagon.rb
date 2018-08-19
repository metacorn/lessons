class PassengerWagon < Wagon
  attr_reader :type, :capacity
  attr_accessor :free_seats
  def initialize(number, capacity)
    super
    @type = "Passenger"
    @capacity = capacity
    @free_seats = capacity
  end

  def take_seat
    self.free_seats -= 1
  end

  def filled_seats
    capacity - free_seats
  end
end
