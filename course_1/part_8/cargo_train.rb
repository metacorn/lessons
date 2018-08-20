class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = "Cargo"
    super(number, type)
  end
end
