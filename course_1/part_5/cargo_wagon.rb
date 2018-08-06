class CargoWagon < Wagon
  attr_reader :type
  def initialize(number)
    super
    @type = "Cargo"
  end
end
