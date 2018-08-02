class Station
  attr_reader :trains, :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def send(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "Train #{train.number} is not at the station #{@name}."
    end
  end

  def receive(train)
    if !@trains.include?(train)
      @trains << train
    else
      puts "Train #{train.number} is at the station #{@name} already."
    end
  end

  def trains_by_type(type)
    trains_by_type = @trains.select { |train| train.type == type}
    puts "Amount of #{type} trains at the station: #{trains_by_type.size}."
    trains_by_type
  end

end
