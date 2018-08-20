class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    @type = "Passenger"
    super(number, type)
  end

  def add_wagon(wagon)
    if wagon.type == "Passenger"
      super(wagon)
    else
      puts "This wagon has wrong type (#{wagon.type.downcase})! Type should be passenger!"
    end
  end
end
