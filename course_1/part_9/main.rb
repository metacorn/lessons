class Main
  require_relative 'interface.rb'
  require_relative 'station.rb'
  require_relative 'route.rb'
  require_relative 'train.rb'
  require_relative 'cargo_train.rb'
  require_relative 'passenger_train.rb'
  require_relative 'wagon.rb'
  require_relative 'cargo_wagon.rb'
  require_relative 'passenger_wagon.rb'

  attr_reader :interface

  WTF_MSG = "I don't understand you!".freeze

  def start
    @stations_list ||= []
    @routes_list ||= []
    @trains_list ||= []
    @wagons_list ||= []
    @interface = Interface.new
    start_menu
  end

  private

  START_MENU = [
    ['manage stations', 'stations_menu'],
    ['manage routes', 'routes_menu'],
    ['manage trains', 'trains_menu'],
    ['manage wagons', 'wagons_menu'],
    ['exit program', 'exit']
  ].freeze
  STATIONS_MENU = [
    ['create a station', 'create_station_menu'],
    ['show trains at the station', 'show_trains_menu'],
    ['show existing stations', 'show_all_stations_menu'],
    ['show number of stations', 'show_station_instances_menu'],
    ['back to start menu', 'start_menu']
  ].freeze
  ROUTES_MENU = [
    ['create a route', 'create_route_menu'],
    ['add a station to the route', 'add_station_menu'],
    ['remove a station from the route', 'remove_station_menu'],
    ['show stations of the route', 'show_route_stations_menu'],
    ['show number of existing routes', 'show_route_instances_menu'],
    ['back to start menu', 'start_menu']
  ].freeze
  TRAINS_MENU = [
    ['create a train', 'create_train_menu'],
    ['add a wagon to the train', 'add_wagon_menu'],
    ['remove a wagon from the train', 'remove_wagon_menu'],
    ['show wagons of the train', 'show_wagons_menu'],
    ['aplly a route for the train', 'set_route_menu'],
    ['move the train to the next station', 'move_forward_menu'],
    ['move the train to the previous station', 'move_back_menu'],
    ['set train manufacturer', 'set_train_manufacturer_menu'],
    ['show train manufacturer', 'show_train_manufacturer_menu'],
    ['show number of existing trains', 'show_train_instances_menu'],
    ['back to start menu', 'start_menu']
  ].freeze
  WAGONS_MENU = [
    ['create a wagon', 'create_wagon_menu'],
    ['set wagon manufacturer', 'set_wagon_manufacturer_menu'],
    ['show wagon manufacturer', 'show_wagon_manufacturer_menu'],
    ['take a seat in passenger wagon', 'take_seat_menu'],
    ['take a volume in cargo wagon', 'take_volume_menu'],
    ['back to start menu', 'start_menu']
  ].freeze

  def action_of(menu)
    item_index = @interface.show_menu(menu)
    choise = menu[item_index - 1]
    action = choise[1]
    send(action)
  end

  def start_menu
    action_of(START_MENU)
  end

  def stations_menu
    action_of(STATIONS_MENU)
  end

  def routes_menu
    action_of(ROUTES_MENU)
  end

  def trains_menu
    action_of(TRAINS_MENU)
  end

  def wagons_menu
    action_of(WAGONS_MENU)
  end

  #  методы меню stations_menu

  def create_station_menu
    name = new_station_name
    @stations_list << Station.new(name)
    @interface.station_created_msg(name)
    stations_menu
  end

  def show_trains_menu
    name = existing_station_name
    station = station_by_name(name)
    @interface.show_trains(station)
    stations_menu
  end

  def show_all_stations_menu
    @interface.show_all_stations_header
    Station.all.each_with_index do |station, index|
      puts "#{index + 1}. #{station.name}."
    end
    stations_menu
  end

  def show_station_instances_menu
    @interface.show_station_instances
    stations_menu
  end

  #  методы меню routes_menu

  def create_route_menu
    first_station_name = first_station_name
    last_station_name = last_station_name
    number = new_route_number
    first_station = station_by_name(first_station_name)
    last_station = station_by_name(last_station_name)
    @routes_list << Route.new(number, first_station, last_station)
    @interface.route_created_msg(number)
    routes_menu
  end

  def add_station_menu
    number = existing_route_number
    name = existing_station_name
    route = route_by_number(number)
    station = station_by_name(name)
    route.add_station(station)
    routes_menu
  end

  def remove_station_menu
    number = existing_route_number
    name = existing_station_name
    route = route_by_number(number)
    station = station_by_name(name)
    route.remove_station(station)
    routes_menu
  end

  def show_route_stations_menu
    number = existing_route_number
    route = route_by_number(number)
    @interface.show_stations(route)
    routes_menu
  end

  def show_route_instances_menu
    @interface.show_route_instances
    routes_menu
  end

  #  методы меню trains_menu

  def create_train_menu
    number = new_train_number
    type = @interface.ask_type
    create_train_of_type(number, type)
  rescue RuntimeError
    @interface.invalid_train_number_msg
    retry
  ensure
    @interface.train_created_msg(type, number)
    trains_menu
  end

  def add_wagon_menu
    train_number = existing_train_number
    wagon_number = existing_wagon_number
    train = train_by_number(train_number)
    wagon = wagon_by_number(wagon_number)
    train.add_wagon(wagon)
    trains_menu
  end

  def remove_wagon_menu
    train_number = existing_train_number
    wagon_number = existing_wagon_number
    train = train_by_number(train_number)
    wagon = wagon_by_number(wagon_number)
    train.remove_wagon(wagon)
    trains_menu
  end

  def show_wagons_menu
    train_number = existing_train_number
    train = train_by_number(train_number)
    @interface.show_wagons(train)
    trains_menu
  end

  def set_route_menu
    train_number = existing_train_number
    route_number = existing_route_number
    train = train_by_number(train_number)
    route = route_by_number(route_number)
    train.get_the_route(route)
    trains_menu
  end

  def move_forward_menu
    train_number = existing_train_number
    train = train_by_number(train_number)
    train.forward
    trains_menu
  end

  def move_back_menu
    train_number = existing_train_number
    train = train_by_number(train_number)
    train.back
    trains_menu
  end

  def set_train_manufacturer_menu
    train_number = existing_train_number
    train = train_by_number(train_number)
    manufacturer_name = manufacturer_name
    train.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(train, manufacturer_name)
    trains_menu
  end

  def show_train_manufacturer_menu
    train_number = existing_train_number
    train = train_by_number(train_number)
    manufacturer_name = train.manufacturer
    @interface.show_manufacturer(train, manufacturer_name)
    trains_menu
  end

  def show_train_instances_menu
    @interface.show_train_instances
    trains_menu
  end

  # методы меню wagons_menu

  def create_wagon_menu
    number = new_wagon_number
    type = @interface.ask_type
    create_wagon_of_type(number, type)
    @interface.wagon_created_msg(type, number)
    wagons_menu
  end

  def set_wagon_manufacturer_menu
    wagon_number = existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = manufacturer_name
    wagon.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(wagon, manufacturer_name)
    wagons_menu
  end

  def show_wagon_manufacturer_menu
    wagon_number = existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = wagon.manufacturer
    @interface.show_manufacturer(wagon, manufacturer_name)
    wagons_menu
  end

  def take_seat_menu
    wagon_number = existing_wagon_number
    wagon = existing_passenger_wagon(wagon_number)
    if wagon.take_space
      @interface.seat_taken_msg
    else
      @interface.passenger_wagon_filled_msg
    end
    wagons_menu
  end

  def take_volume_menu
    wagon_number = existing_wagon_number
    wagon = existing_cargo_wagon(wagon_number)
    volume = @interface.ask_volume
    if wagon.take_space(volume)
      @interface.volume_taken
    else
      @interface.cargo_wagon_filled_msg
    end
    wagons_menu
  end

  def existing_passenger_wagon(wagon_number)
    wagon = wagon_by_number(wagon_number)
    until wagon.type == 'Passenger'
      @interface.wrong_wagon_type_for_passenger_msg
      wagon_number = existing_wagon_number
      wagon = wagon_by_number(wagon_number)
    end
  end

  def existing_cargo_wagon(wagon_number)
    wagon = wagon_by_number(wagon_number)
    until wagon.type == 'Cargo'
      @interface.wrong_wagon_type_for_cargo_msg
      wagon_number = existing_wagon_number
      wagon = wagon_by_number(wagon_number)
    end
  end

  # дополнительные методы
  def route_exist?(number)
    @routes_list.any? { |route| route.number == number }
  end

  def station_exist?(name)
    @stations_list.any? { |station| station.name == name }
  end

  def train_exist?(number)
    @trains_list.any? { |train| train.number == number }
  end

  def wagon_exist?(number)
    @wagons_list.any? { |wagon| wagon.number == number }
  end

  def route_by_number(number)
    @routes_list.each { |route| return route if route.number == number }
  end

  def station_by_name(name)
    @stations_list.each { |station| return station if station.name == name }
  end

  def train_by_number(number)
    @trains_list.each { |train| return train if train.number == number }
  end

  def wagon_by_number(number)
    @wagons_list.each { |wagon| return wagon if wagon.number == number }
  end

  def new_station_name
    name = @interface.ask_station_name
    name = @interface.ask_station_name_if_exist while station_exist?(name)
    name
  end

  def existing_station_name
    name = @interface.ask_station_name
    name = @interface.ask_station_name_if_not_exist until station_exist?(name)
    name
  end

  def first_station_name
    name = @interface.ask_first_station_name
    name = @interface.ask_station_name_if_not_exist until station_exist?(name)
    name
  end

  def last_station_name
    name = @interface.ask_last_station_name
    name = @interface.ask_station_name_if_not_exist until station_exist?(name)
    name
  end

  def new_route_number
    number = @interface.ask_route_number
    number = @interface.ask_route_number_if_exist while route_exist?(number)
    number
  end

  def existing_route_number
    number = @interface.ask_route_number
    number = @interface.ask_route_number_if_not_exist until route_exist?(number)
    number
  end

  def new_train_number
    number = @interface.ask_train_number
    number = @interface.ask_train_number_if_exist while train_exist?(number)
    number
  end

  def new_wagon_number
    number = @interface.ask_wagon_number
    number = @interface.ask_wagon_number_if_exist while wagon_exist?(number)
    number
  end

  def create_train_of_type(number, type)
    case type
    when 'Cargo' then @trains_list << CargoTrain.new(number)
    when 'Passenger' then @trains_list << PassengerTrain.new(number)
    end
  end

  def create_wagon_of_type(number, type)
    case type
    when 'Cargo'
      volume = @interface.ask_wagon_volume
      @wagons_list << CargoWagon.new(number, volume)
    when 'Passenger'
      capacity = @interface.ask_wagon_capacity
      @wagons_list << PassengerWagon.new(number, capacity)
    end
  end

  def existing_train_number
    number = @interface.ask_train_number
    number = @interface.ask_train_number_if_not_exist until train_exist?(number)
    number
  end

  def existing_wagon_number
    number = @interface.ask_wagon_number
    number = @interface.ask_wagon_number_if_not_exist until wagon_exist?(number)
    number
  end

  def manufacturer_name
    @interface.ask_manufacturer_name
  end
end
