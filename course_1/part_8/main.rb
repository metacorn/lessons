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

  WTF_MSG = "I don't understand you!"

  def start
    @stations_list ||= []
    @routes_list ||= []
    @trains_list ||= []
    @wagons_list ||= []
    @interface = Interface.new
    start_menu
  end

private

  def start_menu
    menu_item = @interface.show_start_menu
    case menu_item
    when 1 then stations_menu
    when 2 then routes_menu
    when 3 then trains_menu
    when 4 then wagons_menu
    when 5 then break while true # мне бы хотелось, чтобы выход в irb происходил просто по break, но при запуске программы вылетает исключение: "/home/gluck/Git/lessons/course_1/part_7/main.rb: /home/gluck/Git/lessons/course_1/part_7/main.rb:33: Invalid break (SyntaxError)"
    end
  end

# методы меню start_menu

  def stations_menu
    menu_item = @interface.show_stations_menu
    case menu_item
    when 1 then create_station_menu
    when 2 then show_trains_menu
    when 3 then show_all_stations_menu
    when 4 then show_station_instances_menu
    when 5 then start_menu
    end
  end

  def routes_menu
    menu_item = @interface.show_routes_menu
    case menu_item
    when 1 then create_route_menu
    when 2 then add_station_menu
    when 3 then remove_station_menu
    when 4 then show_route_stations_menu
    when 5 then show_route_instances_menu
    when 6 then start_menu
    end
  end

  def trains_menu
    menu_item = @interface.show_trains_menu
    case menu_item
    when 1 then create_train_menu
    when 2 then add_wagon_menu
    when 3 then remove_wagon_menu
    when 4 then show_wagons_menu
    when 5 then set_route_menu
    when 6 then move_forward_menu
    when 7 then move_back_menu
    when 8 then set_train_manufacturer_menu
    when 9 then get_train_manufacturer_menu
    when 10 then show_train_instances_menu
    when 11 then start_menu
    end
  end

  def wagons_menu
    menu_item = @interface.show_wagons_menu
    case menu_item
    when 1 then create_wagon_menu
    when 2 then set_wagon_manufacturer_menu
    when 3 then get_wagon_manufacturer_menu
    when 4 then take_seat_menu
    when 5 then take_volume_menu
    end
  end

#  методы меню stations_menu

  def create_station_menu
    name = get_new_station_name
    @stations_list << Station.new(name)
    @interface.station_created_msg(name)
    stations_menu
  end

  def show_trains_menu
    name = get_existing_station_name
    station = station_by_name(name)
    @interface.show_trains(station)
    stations_menu
  end

  def show_all_stations_menu
    @interface.show_all_stations_header
    Station.all.each_with_index { |station, index| puts "#{index + 1}. #{station.name}." }
    stations_menu
  end

  def show_station_instances_menu
    @interface.show_station_instances
    stations_menu
  end

#  методы меню routes_menu

  def create_route_menu
    first_station_name = get_first_station_name
    last_station_name = get_last_station_name
    number = get_new_route_number
    first_station = station_by_name(first_station_name)
    last_station = station_by_name(last_station_name)
    @routes_list << Route.new(number, first_station, last_station)
    @interface.route_created_msg(number)
    routes_menu
  end

  def add_station_menu
    number = get_existing_route_number
    name = get_existing_station_name
    route = route_by_number(number)
    station = station_by_name(name)
    route.add_station(station)
    routes_menu
  end

  def remove_station_menu
    number = get_existing_route_number
    name = get_existing_station_name
    route = route_by_number(number)
    station = station_by_name(name)
    route.remove_station(station)
    routes_menu
  end

  def show_route_stations_menu
    number = get_existing_route_number
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
    number = get_new_train_number
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
    train_number = get_existing_train_number
    wagon_number = get_existing_wagon_number
    train = train_by_number(train_number)
    wagon = wagon_by_number(wagon_number)
    train.add_wagon(wagon)
    trains_menu
  end

  def remove_wagon_menu
    train_number = get_existing_train_number
    wagon_number = get_existing_wagon_number
    train = train_by_number(train_number)
    wagon = wagon_by_number(wagon_number)
    train.remove_wagon(wagon)
    trains_menu
  end

  def show_wagons_menu
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    @interface.show_wagons(train)
    trains_menu
  end

  def set_route_menu
    train_number = get_existing_train_number
    route_number = get_existing_route_number
    train = train_by_number(train_number)
    route = route_by_number(route_number)
    train.get_the_route(route)
    trains_menu
  end

  def move_forward_menu
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    train.forward
    trains_menu
  end

  def move_back_menu
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    train.back
    trains_menu
  end

  def set_train_manufacturer_menu
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    manufacturer_name = get_manufacturer_name
    train.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(train, manufacturer_name)
    trains_menu
  end

  def get_train_manufacturer_menu
    train_number = get_existing_train_number
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
    number = get_new_wagon_number
    type = @interface.ask_type
    create_wagon_of_type(number, type)
    @interface.wagon_created_msg(type, number)
    wagons_menu
  end

  def set_wagon_manufacturer_menu
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = get_manufacturer_name
    wagon.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(wagon, manufacturer_name)
    wagons_menu
  end

  def get_wagon_manufacturer_menu
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = wagon.manufacturer
    @interface.show_manufacturer(wagon, manufacturer_name)
    wagons_menu
  end

  def take_seat_menu
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    until wagon.type == "Passenger"
      @interface.wrong_wagon_type_for_passenger_msg
      wagon_number = get_existing_wagon_number
      wagon = wagon_by_number(wagon_number)
    end
    if wagon.free_seats > 0
      wagon.take_seat
    else
      @interface.passenger_wagon_filled_msg
    end
    wagons_menu
  end

  def take_volume_menu
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    until wagon.type == "Cargo"
      @interface.wrong_wagon_type_for_cargo_msg
      wagon_number = get_existing_wagon_number
      wagon = wagon_by_number(wagon_number)
    end
    volume = get_volume
    if volume < wagon.free_volume
      wagon.take_volume(volume)
    else
      @interface.cargo_wagon_filled_msg
    end
    wagons_menu
  end

# дополнительные методы
  def route_exist?(number)
    @routes_list.any? { |route| route.number == number}
  end

  def station_exist?(name)
    @stations_list.any? { |station| station.name == name}
  end

  def train_exist?(number)
    @trains_list.any? { |train| train.number == number}
  end

  def wagon_exist?(number)
    @wagons_list.any? { |wagon| wagon.number == number}
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

  def get_new_station_name
    name = @interface.ask_station_name
    while station_exist?(name)
      name = @interface.ask_station_name_if_exist
    end
    name
  end

  def get_existing_station_name
    name = @interface.ask_station_name
    until station_exist?(name)
      name = @interface.ask_station_name_if_not_exist
    end
    name
  end

  def get_first_station_name
    name = @interface.ask_first_station_name
    until station_exist?(name)
      name = @interface.ask_station_name_if_not_exist
    end
    name
  end

  def get_last_station_name
    name = @interface.ask_last_station_name
    until station_exist?(name)
      name = @interface.ask_station_name_if_not_exist
    end
    name
  end

  def get_new_route_number
    number = @interface.ask_route_number
    while route_exist?(number)
      number = @interface.ask_route_number_if_exist
    end
    number
  end

  def get_existing_route_number
    number = @interface.ask_route_number
    until route_exist?(number)
      number = @interface.ask_route_number_if_not_exist
    end
    number
  end

  def get_new_train_number
    number = @interface.ask_train_number
    while train_exist?(number)
      number = @interface.ask_train_number_if_exist
    end
    number
  end

  def get_new_wagon_number
    number = @interface.ask_wagon_number
    while wagon_exist?(number)
      number = @interface.ask_wagon_number_if_exist
    end
    number
  end

  def create_train_of_type(number, type)
    case type
    when "Cargo" then @trains_list << CargoTrain.new(number, type)
    when "Passenger" then @trains_list << PassengerTrain.new(number, type)
    end
  end

  def create_wagon_of_type(number, type)
    case type
    when "Cargo"
      volume = @interface.ask_wagon_volume
      @wagons_list << CargoWagon.new(number, volume)
    when "Passenger"
      capacity = @interface.ask_wagon_capacity
      @wagons_list << PassengerWagon.new(number, capacity)
    end
  end

  def get_existing_train_number
    number = @interface.ask_train_number
    until train_exist?(number)
      number = @interface.ask_train_number_if_not_exist
    end
    number
  end

  def get_existing_wagon_number
    number = @interface.ask_wagon_number
    until wagon_exist?(number)
      number = @interface.ask_wagon_number_if_not_exist
    end
    number
  end

  def get_manufacturer_name
    @interface.ask_manufacturer_name
  end

  def get_volume
    @interface.ask_volume
  end
end
