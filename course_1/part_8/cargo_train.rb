class CargoTrain < Train
  attr_reader :type

  def initialize(number)
    @type = "Cargo"
    super(number, type)
  end

  def add_wagon(wagon)
    if wagon.type == "Cargo"
      super(wagon)
    else
      puts "This wagon has wrong type (#{wagon.type.downcase})! Type should be cargo!"
    end
  end
end
