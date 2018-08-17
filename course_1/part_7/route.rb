require_relative 'instance_counter.rb'
require_relative 'validity.rb'

class Route
  include InstanceCounter
  include Validity

  attr_reader :stations, :number
  def initialize(number, start, finish)
    @stations = [start, finish]
    @number = number
    validate!
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

  private

  ROUTE_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы

  def validate!
    raise "Wrong class of object passed as the first station: #{first_station.class.to_s}. It should be \"Station\"." if !first_station.instance_of?(Station)
    raise "Wrong class of object passed as the last station: #{last_station.class.to_s}. It should be \"Station\"." if !last_station.instance_of?(Station)
    raise "Route should have different stations as its first and its last ones!" if first_station == last_station
    raise "Route number can't be nil!" if number.nil?
    raise "Route number should contain letters, numbers or hyphens!" if number !~ ROUTE_NUMBER_PATTERN
  end
end
