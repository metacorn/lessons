require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'cargo_wagon.rb'
require_relative 'passenger_wagon.rb'

$stations_list = []
$routes_list = []
$trains_list = []
$wagons_list = []

WTF_MSG = "I don't understand you!"

=begin
def seed
  $dynamo = Station.new("Dynamo")
  $stations_list << $dynamo
  $aeroport = Station.new("Aeroport")
  $stations_list << $aeroport
  $sokol = Station.new("Sokol")
  $stations_list << $sokol
  $hovrino = Station.new("Hovrino")
  $stations_list << $hovrino

  $green = Route.new("Green", $dynamo, $sokol)
  $routes_list << $green

  $t1 = Train.new("1", "Passenger")
  $trains_list << $t1
  $t2 = Train.new("2", "Cargo")
  $trains_list << $t2

  $w11 = Wagon.new("1-1", "Passenger")
  $wagons_list << $w11
  $w21 = Wagon.new("2-1", "Cargo")
  $wagons_list << $w21
end
=end

def start
  start_menu
end

def start_menu
  start_menu = 0
  until (1..4).include?(start_menu)
    puts "\nChoose the action (put the number):"
    puts "1. Manage stations."
    puts "2. Manage routes."
    puts "3. Manage trains."
    puts "4. Exit menu."
    start_menu = gets.to_i

  case start_menu
  when 1
    manage_stations
  when 2
    manage_routes
  when 3
    manage_trains
  when 4
    break if true #можно ли как-то логичней и изящней выйти из case..when?
  else
      puts WTF_MSG
      start
    end
  end
end

def manage_stations
  stations_menu = 0
  until (1..3).include?(stations_menu)
    puts "\nChoose the action (put the number):"
    puts "1. Create a station."
    puts "2. Show trains at the station."
    puts "3. Back to start menu."
    stations_menu = gets.to_i

    case stations_menu
    when 1
      name = get_id_of_new("the name of the station")
      $stations_list << Station.new(name)
      puts "\nStation \"#{name}\" was created!"
      manage_stations
    when 2
      name = get_station_name("an existing")
      station = station_by_name(name)
      if station.trains.empty?
        puts "\nThere are no trains at the station!"
      else
        puts "\nNumbers of trains at the station:"
        station.trains.each {|train| puts train.number}
      end
      manage_stations
    when 3
      start_menu
    else
      puts WTF_MSG
    end
  end
end

def manage_routes
  routes_menu = 0
  until (1..5).include?(routes_menu)
    puts "\nChoose the action (put the number):"
    puts "1. Create a route."
    puts "2. Add a station to a route."
    puts "3. Remove a station from a route."
    puts "4. Show stations in a route."
    puts "5. Back to the start menu."
    routes_menu = gets.to_i

    case routes_menu
    when 1
      number = get_id_of_new("the number of the route")
      first_station = get_station_name("the arrival")
      last_station = get_station_name("the departure")
      $routes_list << Route.new(number, first_station, last_station)
      puts "\nRoute number #{number} was created!"
      manage_routes
    when 2
      number = get_route_number
      route = route_by_number(number)
      name = get_station_name("an existing")
      station = station_by_name(name)
      route.add_station(station)
      manage_routes
    when 3
      number = get_route_number
      route = route_by_number(number)
      name = get_station_name("an existing")
      station = station_by_name(name)
      route.remove_station(station)
      manage_routes
    when 4
      number = get_route_number
      route = route_by_number(number)
      puts "\nStations in the route number #{number}:"
      route.print_stations
      manage_routes
    when 5
      start_menu
    else
      puts WTF_MSG
    end
  end
end

def manage_trains
  trains_menu = 0
  until (1..8).include?(trains_menu)
    puts "\nChoose the action (put the number):"
    puts "1. Create a train."
    puts "2. Create a wagon."
    puts "3. Add wagons to a train."
    puts "4. Remove wagons from a train."
    puts "5. Choose a route for a train."
    puts "6. Move a train to the next station."
    puts "7. Move a train to the previous station."
    puts "8. Back to the start menu."
    trains_menu = gets.to_i

    case trains_menu
    when 1
      number = get_id_of_new("the number of train")
      type = get_type_of_new
      case type
      when "Cargo" then $trains_list << CargoTrain.new(number)
      when "Passenger" then $trains_list << PassengerTrain.new(number)
      end
      puts "\n#{type} train with number #{number} was created!"
      manage_trains
    when 2
      number = get_id_of_new("the number of wagon")
      type = get_type_of_new
      case type
      when "Cargo" then $wagons_list << CargoWagon.new(number)
      when "Passenger" then $wagons_list << PassengerWagon.new(number)
      end
      puts "\n#{type} wagon with number #{number} was created!"
      manage_trains
    when 3
      train_number = get_train_number
      train = train_by_number(train_number)
      wagon_number = get_wagon_number
      wagon = wagon_by_number(wagon_number)
      train.add_wagon(wagon)
      manage_trains
    when 4
      train_number = get_train_number
      train = train_by_number(train_number)
      wagon_number = get_wagon_number
      wagon = wagon_by_number(wagon_number)
      train.remove_wagon(wagon)
      manage_trains
    when 5
      train_number = get_train_number
      train = train_by_number(train_number)
      route_number = get_route_number
      route = route_by_number(route_number)
      train.get_the_route(route)
      manage_trains
    when 6
      train_number = get_train_number
      train = train_by_number(train_number)
      train.forward
      manage_trains
    when 7
      train_number = get_train_number
      train = train_by_number(train_number)
      train.back
      manage_trains
    when 8
      start_menu
    else
      puts WTF_MSG
    end
  end
end

def get_id_of_new(insertion)
  puts "Input #{insertion}:"
  gets.chomp
end

def get_type_of_new
  type_code = 0
  until ["P", "C"].include?(type_code)
    puts "Input the type (\"P\" for passenger, \"C\" for cargo):"
    type_code = gets.chomp.capitalize
  end
  if type_code == "P"
    return "Passenger"
  else
    "Cargo"
  end
end

def get_route_number
  existance = false
  until existance
    puts "Input the number of an existing route:"
    route_number = gets.chomp
    existance = route_exist?(route_number)
  end
  route_number
end

def get_station_name(insertion)
  existance = false
  until existance
    puts "Input the name of #{insertion} station:"
    station_name = gets.chomp
    existance = station_exist?(station_name)
  end
  station_name
end

def get_train_number
  existance = false
  until existance
    puts "Input the number of an existing train:"
    train_number = gets.chomp
    existance = train_exist?(train_number)
  end
  train_number
end

def get_wagon_number
  existance = false
  until existance
    puts "Input the number of an existing wagon:"
    wagon_number = gets.chomp
    existance = wagon_exist?(wagon_number)
  end
  wagon_number
end

def route_exist?(number)
  routes_numbers = []
  $routes_list.each { |route| routes_numbers << route.number }
  routes_numbers.include?(number)
end

def station_exist?(name)
  stations_names = []
  $stations_list.each { |station| stations_names << station.name }
  stations_names.include?(name)
end

def train_exist?(number)
  trains_numbers = []
  $trains_list.each { |train| trains_numbers << train.number }
  trains_numbers.include?(number)
end

def wagon_exist?(number)
  wagons_numbers = []
  $wagons_list.each { |wagon| wagons_numbers << wagon.number }
  wagons_numbers.include?(number)
end

def route_by_number(number)
  $routes_list.each { |route| return route if route.number == number }
end

def station_by_name(name)
  $stations_list.each { |station| return station if station.name == name }
end

def train_by_number(number)
  $trains_list.each { |train| return train if train.number == number }
end

def wagon_by_number(number)
  $wagons_list.each { |wagon| return wagon if wagon.number == number }
end
