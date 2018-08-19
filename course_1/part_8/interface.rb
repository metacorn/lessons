class Interface
  def show_start_menu
    menu_item = 0
    until (1..5).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Manage stations."
      puts "2. Manage routes."
      puts "3. Manage trains."
      puts "4. Manage wagons."
      puts "5. Exit program."
      menu_item = gets.to_i
    end
    menu_item
  end

  def show_stations_menu
    menu_item = 0
    until (1..5).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a station."
      puts "2. Show trains at the station."
      puts "3. Show all existing stations."
      puts "4. Show number of stations."
      puts "5. Back to start menu."
      menu_item = gets.to_i
    end
    menu_item
  end

  def show_routes_menu
    menu_item = 0
    until (1..6).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a route."
      puts "2. Add a station to a route."
      puts "3. Remove a station from a route."
      puts "4. Show stations in a route."
      puts "5. Show number of routes."
      puts "6. Back to the start menu."
      menu_item = gets.to_i
    end
    menu_item
  end

  def show_trains_menu
    menu_item = 0
    until (1..11).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a train."
      puts "2. Add wagons to a train."
      puts "3. Remove wagons from a train."
      puts "4. Show wagons of a train."
      puts "5. Set a route for a train."
      puts "6. Move a train to the next station."
      puts "7. Move a train to the previous station."
      puts "8. Set the manufacturer to the train."
      puts "9. Show the manufacturer of the train."
      puts "10. Show number of trains."
      puts "11. Back to the start menu."
      menu_item = gets.to_i
    end
    menu_item
  end

  def show_wagons_menu
    menu_item = 0
    until (1..5).include?(menu_item)
      puts "\nChoose the action (put the number):"
      puts "1. Create a wagon."
      puts "2. Set the manufacturer to the wagon."
      puts "3. Show the manufacturer of the wagon."
      puts "4. Take a seat in passenger wagon."
      puts "5. Take a volume in cargo wagon."
      menu_item = gets.to_i
    end
    menu_item
  end

  def ask_station_name
    puts "\nInput the name of station:"
    gets.chomp
  end

  def ask_station_name_if_exist
    puts "\nStation with such name already exists, input another name:"
    gets.chomp
  end

  def ask_station_name_if_not_exist
    puts "\nStation with such name does not exist, input the name of an existing one:"
    gets.chomp
  end

  def station_created_msg(name)
    puts "\nStation #{name} was created!"
  end

  def show_all_stations_header
    puts "\nExisting stations:"
  end

  def show_station_instances
    Station.instances ||= 0
    puts "\nNumber of stations: #{Station.instances}."
  end

  def show_trains(station)
    if station.trains.empty?
      puts "\nThere are no trains at the station!"
    else
      puts "\nTrains at the station:"
      station.present_trains {|train| puts "№#{train.number}; #{train.type.downcase} type; number of wagons: #{train.wagons.size}."}
    end
  end

  def ask_route_number
    puts "\nInput the number of the route:"
    gets.chomp
  end

  def ask_route_number_if_exist
    puts "\nRoute with such number already exists, input another number:"
    gets.chomp
  end

  def ask_route_number_if_not_exist
    puts "\nRoute with such number does not exist, input the number of an existing one:"
    gets.chomp
  end

  def route_created_msg(number)
    puts "\nRoute #{number} was created!"
  end

  def ask_first_station_name
    puts "\nInput the name of the first station:"
    gets.chomp
  end

  def ask_last_station_name
    puts "\nInput the name of the last station:"
    gets.chomp
  end

  def show_stations(route)
    puts "\nStations in the route #{route.number}:"
    route.stations.each {|station| puts station.name}
  end

  def show_route_instances
    Route.instances ||= 0
    puts "\nNumber of routes: #{Route.instances}."
  end

  def ask_train_number
    puts "\nInput the number of the train:"
    gets.chomp
  end

  def ask_train_number_if_exist
    puts "\nTrain with such number already exists, input another number:"
    gets.chomp
  end

  def ask_train_number_if_not_exist
    puts "\nTrain with such number does not exist, input the number of an existing one:"
    gets.chomp
  end

  def train_created_msg(type, number)
    puts "\n#{type} train #{number} was created!"
  end

  def ask_type
    type_code = 0
    until ["P", "C"].include?(type_code)
      puts "\nInput the type (\"P\" for passenger, \"C\" for cargo):"
      type_code = gets.chomp.capitalize
    end
    if type_code == "P"
      return "Passenger"
    else
      "Cargo"
    end
  end

  def ask_wagon_number
    puts "\nInput the number of the wagon:"
    gets.chomp
  end

  def ask_wagon_number_if_exist
    puts "\nWagon with such number already exists, input another number:"
    gets.chomp
  end

  def ask_wagon_number_if_not_exist
    puts "\nWagon with such number does not exist, input the number of an existing one:"
    gets.chomp
  end

  def ask_wagon_capacity
    puts "\nInput the capacity of the wagon (in seats):"
    gets.to_i
  end

  def ask_wagon_volume
    puts "\nInput the volume of the wagon (in cubic meters):"
    gets.to_f
  end

  def wagon_created_msg(type, number)
    puts "\n#{type} wagon #{number} was created!"
  end

  def no_free_seats_msg
    puts "\nThere are no free seats in this wagon!"
  end

  def ask_manufacturer_name
    puts "\nInput the manufacturer's name:"
    gets.chomp
  end

  def set_manufacturer_msg(instance, manufacturer_name)
    puts "\nManufacturer of this #{instance.class.superclass.to_s.downcase} was defined as #{manufacturer_name}!"
  end

  def show_manufacturer(instance, manufacturer_name)
    puts "\nManufacturer of this #{instance.class.superclass.to_s.downcase} is #{manufacturer_name}."
  end

  def show_train_instances
    CargoTrain.instances ||= 0
    PassengerTrain.instances ||= 0
    total_trains = CargoTrain.instances + PassengerTrain.instances
    puts "\nNumber of trains: #{total_trains}."
  end

  def show_wagons(train)
    if train.wagons.empty?
      puts "\nThere are no wagons at the train!"
    else
      puts "\nWagons of the train:"
      if train.type == "Passenger"
        train.present_wagons {|wagon| puts "№#{wagon.number}; passenger type; number of filled seats: #{wagon.filled_seats}, number of free seats: #{wagon.free_seats}."}
      elsif train.type == "Cargo"
        train.present_wagons {|wagon| puts "№#{wagon.number}; cargo type; amount of filled volume: #{wagon.filled_volume}, amount of free volume: #{wagon.free_volume}."}
      end
    end
  end

  def invalid_train_number_msg
    puts "\nTrain number validation failed! Input valid train number!"
  end

  def wrong_wagon_type_for_passenger_msg
    puts "\nThis is cargo wagon. Choose passenger one."
  end

  def passenger_wagon_filled_msg
    puts "\nThis wagon has no free seats!"
  end

  def wrong_wagon_type_for_cargo_msg
    puts "\nThis is passenger wagon. Choose cargo one."
  end

  def cargo_wagon_filled_msg
    puts "\nThis train has no enough free volume!"
  end

  def ask_volume
    puts "\nInput the volume of cargo (in cubic meters): "
    gets.to_f
  end
end
