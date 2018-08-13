require_relative 'instance_counter.rb'

class Route
  include InstanceCounter

  attr_reader :stations, :number
  def initialize(number, start, finish)
    @stations = [start, finish]
    @number = number
    register_instances
  end

  def print_stations
    stations.each {|station| puts station.name}
  end

  def add_station(station)
    if @stations.include?(station)
      puts "\nThis station is in this route already!"
    else
      @stations.insert(-2, station)
      puts "\nStation #{station.name} was added to the route #{self.number}!"
    end
  end

  def remove_station(station)
    if station == first_station || station == last_station
      puts "\nArrival/departure station can not be removed!"
    elsif !@stations.include?(station)
      puts "\nThis station is not in the route!"
    else
      @stations.delete(station)
      puts "\nStation #{station.name} was removed from the route #{self.number}!"
    end
  end

  def first_station
    stations[0]
  end

  def last_station
    stations[-1]
  end
end
