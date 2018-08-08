class Main
  require_relative 'interface.rb'
  require_relative 'station.rb'

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
    when 1
      name = @interface.get_station_name
      create_station(name)
      manage_stations
    when 2
      show_trains
      manage_stations
    when 3
      start_menu
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
    when 1
      create_route
      manage_routes
    when 2
      add_station
      manage_routes
    when 3
      remove_station
      manage_routes
    when 4
      show_stations
      manage_routes
    when 5
      start_menu
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
    when 1
      create_train
      manage_trains
    when 2
      create_wagon
      manage_trains
    when 3
      add_wagon
      manage_trains
    when 4
      remove_wagon
      manage_trains
    when 5
      set_route
      manage_trains
    when 6
      move_forward
      manage_trains
    when 7
      move_back
      manage_trains
    when 8
      start_menu
    end
  end

#  методы меню manage_stations

  def create_station(name)
    @stations_list << Station.new(name)
  end

  def show_trains
  end

#  методы меню manage_routes

  def create_route
  end

  def add_station
  end

  def remove_station
  end

  def show_stations
  end

#  методы меню manage_trains

  def create_train
  end

  def create_wagon
  end

  def add_wagon
  end

  def remove_wagon
  end

  def set_route
  end

  def move_forward
  end

  def move_back
  end
end
