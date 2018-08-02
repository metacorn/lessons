require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'passenger_train.rb'
require_relative 'passenger_train.rb'
require_relative 'wagon.rb'
require_relative 'passenger_wagon.rb'
require_relative 'passenger_wagon.rb'

def seed
  @s1 = Station.new("Dynamo")
  @s2 = Station.new("Aeroport")
  @s3 = Station.new("Sokol")

  @r1 = Route.new(@s1, @s3)
  @r1.add_station(@s2)

  @t1 = Train.new("1", :pass)

  @t1.get_the_route(@r1)
end

$trains_list ||= []
$wagons_list ||= []
WTF_MSG = "I don't understand you!"

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
    when 2
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
    when 2
    when 3
    when 4
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
    puts "5. Choose a route for a train"
    puts "6. Move a train to the next station"
    puts "7. Move a train to the previous station"
    puts "8. Back to the start menu."
    trains_menu = gets.to_i

    case trains_menu
    when 1
      puts "Input the number:"
      number = gets.chomp
      type_code = 0
      until ["P", "C"].include?(type_code)
        puts "Input the type (\"P\" for passenger, \"C\" for cargo):"
        type_code = gets.chomp.capitalize
      end
      if type_code == "P"
        type = "Passenger"
      else
        type = "Cargo"
      end
      $trains_list << Train.new(number, type)
      puts "\n#{type} train with number #{number} was created!"
      manage_trains
    when 2
      puts "Input the number:"
      number = gets.chomp
      until ["P", "C"].include?(type_code)
        puts "Input the type (\"P\" for passenger, \"C\" for cargo):"
        type_code = gets.chomp.capitalize
      end
      if type_code == "P"
        type = "Passenger"
      else
        type = "Cargo"
      end
      $wagons_list << Wagon.new(number, type)
      puts "\n#{type} wagon with number #{number} was created!"
      manage_trains
    when 3
      puts "Input the number of the train:"
      train_number = gets.chomp
      puts "Input the number of the wagon:"
      wagon_number = gets.chomp
      
    when 4
    when 5
    when 6
    when 7
    when 8
      start_menu
    else
      puts WTF_MSG
    end
  end
end
