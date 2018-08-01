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

class Route
  attr_reader :stations
  def initialize(arrival_station, departure_station)
    @stations = [arrival_station, departure_station]
  end

  def print_stations
    stations.each {|station| puts station.name}
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station == self.first_station || self.last_station
      puts "Arrival/departure station can not be removed!"
    elsif !@stations.include?(station)
      puts "This station is not in the route!"
    else
      @stations.delete(station)
    end
  end

  def first_station
    stations[0]
  end

  def last_station
    stations[-1]
  end
end

class Train
  attr_reader :number, :type, :wagons, :speed, :route, :station
  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
  end

  def speed_up
    @speed += 10
  end

  def speed_down
    @speed -= 10 if @speed >= 10
  end

  def add_wagon
    if speed == 0
      @wagons += 1
    else
      puts "Train #{number} is in the motion!"
    end
  end

  def remove_wagon
    if speed == 0 && wagons > 0 # с учётом того, что что поезд может состоять из одного локомотива без вагонов
      @wagons -= 1
    elsif wagons == 0
      puts "This train has no wagons already!"
    else
      puts "Train #{number} is in the motion!"
    end
  end

  def get_the_route(route)
    @route = route
    @station = @route.stations[0]
    @station.receive(self)
  end

  def index
    route.stations.index(@station)
  end

  def next_station
    route.stations[self.index + 1] if @station != @route.stations[-1]
  end

  def current_station
    station
  end

  def previous_station
    route.stations[self.index - 1] if @station != @route.stations[0]
  end

  def forward
    if next_station
      current_station.send(self)
      next_station.receive(self)
      @station = next_station
    else
      puts "Train #{number} is at its departure station!"
    end
  end

  def back
    if previous_station
      current_station.send(self)
      previous_station.receive(self)
      @station = previous_station
    else
      puts "Train #{number} is at its arrival station!"
    end
  end
end
