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
#  require_relative 'manufacturer.rb'

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
    puts menu_item
    case menu_item
    when 1 then stations_menu
    when 2 then routes_menu
    when 3 then trains_menu
    when 4 then exit
    end
  end

# методы меню start_menu

  def stations_menu
    menu_item = @interface.show_stations_menu
    case menu_item
    when 1 then create_station_menu
    when 2 then show_trains_menu
    when 3 then start_menu
    end
  end

  def routes_menu
    menu_item = @interface.show_routes_menu
    case menu_item
    when 1 then create_route_menu
    when 2 then add_station_menu
    when 3 then remove_station_menu
    when 4 then show_stations_menu
    when 5 then start_menu
    end
  end

  def trains_menu
    menu_item = @interface.show_trains_menu
    case menu_item
    when 1 then create_train_menu
    when 2 then create_wagon_menu
    when 3 then add_wagon_menu
    when 4 then remove_wagon_menu
    when 5 then set_route_menu
    when 6 then move_forward_menu
    when 7 then move_back_menu
    when 8 then set_train_manufacturer
    when 9 then get_train_manufacturer
    when 10 then set_wagon_manufacturer
    when 11 then get_wagon_manufacturer
    when 12 then start_menu
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

  def show_stations_menu
    number = get_existing_route_number
    route = route_by_number(number)
    @interface.show_stations(route)
    routes_menu
  end

#  методы меню trains_menu

  def create_train_menu
    number = get_new_train_number
    type = @interface.ask_type
    create_train_of_type(number, type)
    @interface.train_created_msg(type, number)
    trains_menu
  end

  def create_wagon_menu
    number = get_new_wagon_number
    type = @interface.ask_type
    create_wagon_of_type(number, type)
    @interface.wagon_created_msg(type, number)
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

  def set_train_manufacturer
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    manufacturer_name = get_manufacturer_name
    train.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(train, manufacturer_name)
    trains_menu
  end

  def get_train_manufacturer
    train_number = get_existing_train_number
    train = train_by_number(train_number)
    manufacturer_name = train.manufacturer
    @interface.show_manufacturer(train, manufacturer_name)
    trains_menu
  end

  def set_wagon_manufacturer
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = get_manufacturer_name
    wagon.manufacturer = manufacturer_name
    @interface.set_manufacturer_msg(wagon, manufacturer_name)
    trains_menu
  end

  def get_wagon_manufacturer
    wagon_number = get_existing_wagon_number
    wagon = wagon_by_number(wagon_number)
    manufacturer_name = wagon.manufacturer
    @interface.show_manufacturer(wagon, manufacturer_name)
    trains_menu
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
    when "Cargo" then @trains_list << CargoTrain.new(number)
    when "Passenger" then @trains_list << PassengerTrain.new(number)
    end
  end

  def create_wagon_of_type(number, type)
    case type
    when "Cargo" then @wagons_list << CargoWagon.new(number)
    when "Passenger" then @wagons_list << PassengerWagon.new(number)
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
    name = @interface.ask_manufacturer_name
  end
end
