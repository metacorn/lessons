require_relative 'manufacturer.rb'

class Train
  attr_reader :number, :type, :speed, :route, :wagons, :current_station

#В секции public оставлены классы, к которым по ТЗ должен быть доступ из main.rb
  include Manufacturer

  def initialize(number)
    @number = number
    @wagons = []
    @speed = 0
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
      speed_up
      current_station.send(self)
      next_station.receive(self)
      @current_station = next_station
      speed_down
      puts "\nTrain #{number} moved to the station #{current_station.name}."
    else
      puts "\nTrain #{number} is at its departure station!"
    end
  end

  def back
    if previous_station
      speed_up
      current_station.send(self)
      previous_station.receive(self)
      @current_station = previous_station
      speed_down
      puts "\nTrain #{number} moved to the station #{current_station.name}."
    else
      puts "\nTrain #{number} is at its arrival station!"
    end
  end

  protected

=begin
Методы speed_up и speed_down вынесены в protected, т.к. в ТЗ не прописано, что пользователь должен обладать этим функционалом.
Чтобы наличие методов speed_up и speed_down как таковых было оправданно, добавил их в методы forward и back
=end

  def speed_up
    @speed += 10
  end

  def speed_down
    @speed -= 10 if @speed >= 10
  end
end
