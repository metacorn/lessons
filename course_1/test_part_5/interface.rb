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
    puts "\nStation with such name does not exist, input name of existing one:"
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
    puts "\nInput the number of route:"
    gets.chomp
  end

  def ask_route_number_if_exist
    puts "\nRoute with such number already exists, input another number:"
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
end
