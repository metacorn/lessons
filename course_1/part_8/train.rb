require_relative 'manufacturer.rb'
require_relative 'instance_counter.rb'
require_relative 'validity.rb'

class Train
  include Manufacturer
  include InstanceCounter
  include Validity

  class << self
    attr_reader :all

    def find(train_number)
      all[train_number]
    end

    protected
    attr_writer :all

    def add_train(train)
      self.all[train.number] = train
    end
  end

  @all = {}

  attr_reader :number, :speed, :route, :wagons, :current_station

  # В секции public оставлены классы, к которым по ТЗ должен быть доступ из main.rb

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    validate!
    Train.send(:add_train, self)
    register_instances
  end

  def get_the_route(route)
    @route = route
    @current_station = route.first_station
    @current_station.receive(self)
    puts "\nTrain #{number} got the route #{route.number}."
  end

  def current_index
    route.stations.index(current_station)
  end

  def next_station
    route.stations[current_index + 1] if current_station != route.last_station
  end

  def previous_station
    route.stations[current_index - 1] if current_station != route.first_station
  end

  def forward
    if next_station
      current_station.send(self)
      next_station.receive(self)
      @current_station = next_station
      puts "\nTrain #{number} moved to the station #{current_station.name}."
    else
      puts "\nTrain #{number} is at its departure station!"
    end
  end

  def back
    if previous_station
      current_station.send(self)
      previous_station.receive(self)
      @current_station = previous_station
      puts "\nTrain #{number} moved to the station #{current_station.name}."
    else
      puts "\nTrain #{number} is at its arrival station!"
    end
  end

  def present_wagons
    wagons.each { |wagon| yield(wagon) }
  end

  def add_wagon(wagon)
    if wagon.type != self.type
      puts "\nWrong type of wagon (#{wagon.type.downcase}) for this train!"
    elsif !wagon.free
      puts "\nThis wagon has been added to another train!"
    else
      self.wagons << wagon
      wagon.change_state
      puts "\nThis wagon was added to the train number #{number}."
    end
  end

  def remove_wagon(wagon)
    if !self.wagons.include?(wagon)
      puts "\nThis wagon is not in this train number #{number}!"
    else
      self.wagons.delete(wagon)
      wagon.change_state
      puts "\nThis wagon was removed from the train number #{number}."
    end
  end

  protected

  TRAIN_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9]{3}-*[a-zA-Zа-яА-Я0-9]{2}$/ # согласно ТЗ

  def validate!
    raise "Train number can't be nil!" if number.nil?
    raise "Train number should conform to the established mask!" if number !~ TRAIN_NUMBER_PATTERN
  end
end
