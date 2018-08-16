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
    $validator.check_out!(self)
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

end
