class Interface
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

  def show_trains(station)
    if station.trains.empty?
      puts "\nThere are no trains at the station!"
    else
      puts "\nNumbers of trains at the station:"
      station.trains.each {|train| puts train.number}
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
      puts "Input the type (\"P\" for passenger, \"C\" for cargo):"
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

  def wagon_created_msg(type, number)
    puts "\n#{type} wagon #{number} was created!"
  end
end
