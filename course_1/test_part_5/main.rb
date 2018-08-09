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
    menu_item = 0
    until (1..4).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Manage stations."
      puts "2. Manage routes."
      puts "3. Manage trains."
      puts "4. Exit program."
      menu_item = gets.to_i
    end

    case menu_item
    when 1 then manage_stations
    when 2 then manage_routes
    when 3 then manage_trains
    when 4 then exit
    end
  end

# методы меню start_menu

  def manage_stations
    menu_item = 0
    until (1..3).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a station."
      puts "2. Show trains at the station."
      puts "3. Back to start menu."
      menu_item = gets.to_i
    end

    case menu_item
    when 1 then create_station_menu
    when 2 then show_trains_menu
    when 3 then start_menu
    end
  end

  def manage_routes
    menu_item = 0
    until (1..5).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a route."
      puts "2. Add a station to a route."
      puts "3. Remove a station from a route."
      puts "4. Show stations in a route."
      puts "5. Back to the start menu."
      menu_item = gets.to_i
    end

    case menu_item
    when 1 then create_route_menu
    when 2 then add_station_menu
    when 3 then remove_station_menu
    when 4 then show_stations_menu
    when 5 then start_menu
    end
  end

  def manage_trains
    menu_item = 0
    until (1..8).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a train."
      puts "2. Create a wagon."
      puts "3. Add wagons to a train."
      puts "4. Remove wagons from a train."
      puts "5. Set a route for a train."
      puts "6. Move a train to the next station."
      puts "7. Move a train to the previous station."
      puts "8. Back to the start menu."
      menu_item = gets.to_i
    end

    case menu_item
    when 1 then create_train_menu
    when 2 then create_wagon_menu
    when 3 then add_wagon_menu
    when 4 then remove_wagon_menu
    when 5 then set_route_menu
    when 6 then move_forward_menu
    when 7 then move_back_menu
    when 8 then start_menu
    end
  end

#  методы меню manage_stations

  def create_station_menu
    name = @interface.ask_station_name
    loop do
      if station_exist?(name)
        name = @interface.ask_station_name_if_exist
      else
        break
      end
    end
    @stations_list << Station.new(name)
    @interface.station_created_msg(name)
    manage_stations
  end

  def show_trains_menu
    name = @interface.ask_station_name
    loop do
      if !station_exist?(name)
        name = @interface.ask_station_name_if_not_exist
      else
        break
      end
    end
    station = station_by_name(name)
    @interface.show_trains(station)
    manage_stations
  end

#  методы меню manage_routes

  def create_route_menu
    first_station_name = @interface.ask_first_station_name
    loop do
      if !station_exist?(first_station_name)
        first_station_name = @interface.ask_station_name_if_not_exist
      else
        break
      end
    end
    last_station_name = @interface.ask_last_station_name
    loop do
      if !station_exist?(last_station_name)
        last_station_name = @interface.ask_station_name_if_not_exist
      else
        break
      end
    end
    number = @interface.ask_route_number
    loop do
      if route_exist?(number)
        number = @interface.ask_route_number_if_exist
      else
        break
      end
    end
    first_station = station_by_name(first_station_name)
    last_station = station_by_name(last_station_name)
    @routes_list << Route.new(number, first_station, last_station)
    @interface.route_created_msg(number)
    manage_routes
  end

  def add_station_menu

  end

  def remove_station_menu
  end

  def show_stations_menu
  end

#  методы меню manage_trains

  def create_train_menu
  end

  def create_wagon_menu
  end

  def add_wagon_menu
  end

  def remove_wagon_menu
  end

  def set_route_menu
  end

  def move_forward_menu
  end

  def move_back_menu
  end

# дополнительные методы

  def station_exist?(name)
    !@stations_list.none? { |station| station.name == name}
  end

  def route_exist?(number)
    !@routes_list.none? { |route| route.number == number}
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

end
