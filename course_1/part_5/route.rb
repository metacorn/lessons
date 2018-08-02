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
    if station == first_station || last_station
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
