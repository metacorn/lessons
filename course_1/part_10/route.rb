require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Route
  include InstanceCounter
  include Validation

  ROUTE_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я][a-zA-Zа-яА-Я0-9 -]*[a-zA-Zа-яА-Я0-9]+$/

  attr_reader :stations, :number
  validate :number, :presence
  validate :number, :format, ROUTE_NUMBER_PATTERN
  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(number, first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = [first_station, last_station]
    @number = number
    validate!
    register_instances
  end

  def print_stations
    stations.each { |station| puts station.name }
  end

  def add_station(station)
    if @stations.include?(station)
      puts "\nThis station is in this route already!"
    else
      @stations.insert(-2, station)
      puts "\nStation #{station.name} was added to the route #{number}!"
    end
  end

  def remove_station(station)
    if station == first_station
      puts "\nArrival station can not be removed!"
    elsif station == last_station
      puts "\nDeparture station can not be removed!"
    elsif !@stations.include?(station)
      puts "\nThis station is not in the route!"
    else
      @stations.delete(station)
      puts "\nStation #{station.name} was removed from the route #{number}!"
    end
  end

  def first_station
    stations[0]
  end

  def last_station
    stations[-1]
  end

  def validate!
    super(end_stations_validate)
  end

  def end_stations_validate
    if first_station == last_station
      return "Route should have different end stations!"
    else
      return ""
    end
  end
end
