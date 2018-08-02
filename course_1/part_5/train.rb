class Train
  attr_reader :number, :type, :speed, :route, :wagons

#В секции public оставлены классы, к которым по ТЗ должен быть доступ из main.rb

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if wagon.type == type && wagon.free?
  end

  def remove_wagon(wagon)
    if !@wagons.include?(wagon)
      puts "There is no such wagon in this train!"
    else
      @wagons.delete(wagon)
    end
  end

  def get_the_route(route)
    @route = route
    @station = route.first_station
    @station.receive(self)
  end

  def current_index
    route.stations.index(@station)
  end

  def next_station
    route.stations[current_index + 1] if @station != route.last_station
  end

  def current_station
    station
  end

  def previous_station
    route.stations[current_index - 1] if @station != route.first_station
  end

  def forward
    if next_station
      speed_up
      current_station.send(self)
      next_station.receive(self)
      @station = next_station
      speed_down
    else
      puts "Train #{number} is at its departure station!"
    end
  end

  def back
    if previous_station
      speed_up
      current_station.send(self)
      previous_station.receive(self)
      @station = previous_station
      speed_down
    else
      puts "Train #{number} is at its arrival station!"
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
