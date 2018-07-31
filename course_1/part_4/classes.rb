class Station
  attr_reader :trains_at_the_station, :station_name
  def initialize(station_name)
    @station_name = station_name
    @trains_at_the_station = []
  end

  def send_a_train(train)
    if @trains_at_the_station.include?(train)
      train.go_ahead
    else
      puts "Train #{train.train_number} is not at the station #{@station_name}."
    end
  end

  def receive_a_train(train)
    if train.next_station == self
      train.go_ahead
    elsif train.previous_station == self
      train.go_back
    else
      puts "Train #{train.train_number} is not at the nearby station."
    end
  end

  def trains_at_the_station_by_type(train_type)
    return @trains_at_the_station.select { |one_of_the_trains| one_of_the_trains.train_type == train_type}
  end

end

class Route
  attr_reader :stations_in_route
  def initialize(arrival_station, departure_station)
    @stations_in_route = [arrival_station, departure_station]
  end

  def add_intermediate_station(station)
    @stations_in_route.insert(-2, station)
  end

  def remove_intermediate_station(station)
    @stations_in_route.delete(station)
  end
end

class Train
  attr_reader :train_number, :current_speed, :train_length, :current_route, :train_type
  def initialize(train_number, train_type, train_length)
    @train_number = train_number
    @train_type = train_type
    @train_length = train_length
    @current_speed = 0
  end

  def accelerate
    @current_speed += 10
  end

  def stop
    @current_speed = 0
  end

  def add_wagon
    if @current_speed == 0
      @train_length += 1
    else
      puts "Train #{self.train_number} is in the motion!"
    end
  end

  def remove_wagon
    if @current_speed == 0 && @train_length > 0 # с учётом того, что что поезд может состоять из одного локомотива без вагонов
      @train_length -= 1
    elsif @train_length == 0
      puts "This train has no wagons already!"
    else
      puts "Train #{self.train_number} is in the motion!"
    end
  end

  def get_the_route(route)
    @current_route = route
    @current_station = @current_route.stations_in_route[0]
    @current_station.trains_at_the_station << self
  end

  def go_ahead
    if @current_station != @current_route.stations_in_route[-1]
      @current_station.trains_at_the_station.delete(self)
      @current_station = @current_route.stations_in_route[@current_route.stations_in_route.index(@current_station) + 1]
      @current_station.trains_at_the_station << self
      puts "Train #{self.train_number} moved to station #{@current_station.station_name}."
    else
      puts "Train #{self.train_number} is at its departure station!"
    end
  end

  def go_back
    if @current_station != @current_route.stations_in_route[0]
      @current_station.trains_at_the_station.delete(self)
      @current_station = @current_route.stations_in_route[@current_route.stations_in_route.index(@current_station) - 1]
      @current_station.trains_at_the_station << self
      puts "Train #{self.train_number} moved to station #{@current_station.station_name}."
    else
      puts "Train #{self.train_number} is at its arrival station!"
    end
  end

  def current_station
    if @current_route.nil?
      puts "Train #{self.train_number} has no route."
    else
      return @current_station
    end
  end

  def next_station
    if @current_route.nil?
      puts "Train #{self.train_number} has no route."
    elsif @current_station != @current_route.stations_in_route[-1]
      return @current_route.stations_in_route[@current_route.stations_in_route.index(@current_station) + 1]
    else
      puts "Train #{self.train_number} is at its departure station!"
    end
  end

  def previous_station
    if @current_route.nil?
      puts "Train #{self.train_number} has no route."
    elsif @current_station != @current_route.stations_in_route[0]
      return @current_route.stations_in_route[@current_route.stations_in_route.index(@current_station) - 1]
    else
      puts "Train #{self.train_number} is at its arrival station!"
    end
  end
end
