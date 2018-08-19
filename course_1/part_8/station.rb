require_relative 'instance_counter.rb'
require_relative 'validity.rb'

class Station
  include InstanceCounter
  include Validity

  class << self
    attr_reader :all
  end

  @all = []

  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
    validate!
    Station.all << self
    register_instances
  end

  def send(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "\nTrain #{train.number} is not at the station #{@name}."
    end
  end

  def receive(train)
    if !@trains.include?(train)
      @trains << train
    else
      puts "\nTrain #{train.number} is at the station #{@name} already."
    end
  end

  def trains_by_type(type)
    trains_by_type = @trains.select { |train| train.type == type}
    puts "\nAmount of #{type} trains at the station: #{trains_by_type.size}."
    trains_by_type
  end

  def present_trains
    trains.each { |train| yield(train) }
  end

  private

  STATION_NAME_PATTERN = /^[a-zA-Zа-яА-Я0-9 -]+$/ # буквы, цифры, пробелы, дефисы

  def validate!
    raise "Station name can't be nil!" if name.nil?
    raise "Station name should contain letters, numbers, hyphens or spaces!" if name !~ STATION_NAME_PATTERN
  end

end
