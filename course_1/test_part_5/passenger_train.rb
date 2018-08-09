class PassengerTrain < Train
  attr_reader :type

  def initialize(number)
    super
    @type = "Passenger"
  end

  def add_wagon(wagon)
    if wagon.type != self.type
      puts "\nWrong type of wagon (#{wagon.type.downcase}) for this train!"
    elsif !wagon.free?
      puts "\nThis wagon has been added to another train!"
    else
      @wagons << wagon
      puts "\nThis wagon was added to the train number #{number}."
    end
  end

  def remove_wagon(wagon)
    if !@wagons.include?(wagon)
      puts "\nThis wagon is not in this train number #{number}!"
    else
      @wagons.delete(wagon)
      puts "\nThis wagon was removed from the train number #{number}."
    end
  end
end
