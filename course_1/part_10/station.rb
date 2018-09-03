require_relative 'instance_counter.rb'
require_relative 'validation.rb'

class Station
  include InstanceCounter
  include Validation

  class << self
    attr_reader :all
  end

  STATION_NAME_PATTERN = /^[a-zA-Zа-яА-Я][a-zA-Zа-яА-Я0-9 -]*[a-zA-Zа-яА-Я0-9]+$/

  attr_reader :trains, :name
  validate :name, :presence
  validate :name, :format, STATION_NAME_PATTERN

  @all = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    Station.all << self
    register_instances
  end

  def send_train(train)
    if @trains.include?(train)
      @trains.delete(train)
    else
      puts "\nTrain #{train.number} is not at the station #{@name}."
    end
  end

  def receive_train(train)
    if !@trains.include?(train)
      @trains << train
    else
      puts "\nTrain #{train.number} is at the station #{@name} already."
    end
  end

  def trains_by_type(type)
    trains_by_type = @trains.select { |train| train.type == type }
    puts "\nAmount of #{type} trains at the station: #{trains_by_type.size}."
    trains_by_type
  end

  def present_trains
    trains.each { |train| yield(train) }
  end
end
