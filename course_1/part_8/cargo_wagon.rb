class CargoWagon < Wagon
  attr_reader :number, :type, :capacity
  def initialize(number, capacity)
    @type = "Cargo"
    super(number, type, capacity)
  end

  def take_space(space)
    super(space)
  end
end
