class Validator
  def check_out!(data)
    case
    when data.instance_of?(Station)
      station_validate(data)
    when data.instance_of?(Route)
      route_validate(data)
    when data.instance_of?(PassengerTrain), data.instance_of?(CargoTrain)
      train_validate(data)
    when data.instance_of?(PassengerWagon), data.instance_of?(CargoWagon)
      wagon_validate(data)
    end
  end

  private

  STATION_NAME_PATTERN = /^[a-zA-Zа-яА-Я0-9 -]+$/ # буквы, цифры, пробелы, дефисы
  ROUTE_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы
  TRAIN_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9]{3}-*[a-zA-Zа-яА-Я0-9]{2}$/ # согласно ТЗ
  WAGON_NUMBER_PATTERN = /^[a-zA-Zа-яА-Я0-9-]+$/ # буквы, цифры, дефисы

  def station_validate(station)
    if station.name.nil?
      raise "Station name can't be nil!"
    end
    if station.name !~ STATION_NAME_PATTERN
      raise "Station name should contain letters, numbers, hyphens or spaces!"
    end
    true
  end

  def route_validate(route)
    if !route.first_station
      raise "Route should have the arrival station!"
    end
    if !route.last_station
      raise "Route should have the departure station!"
    end
    if route.number.nil?
      raise "Route number can't be nil!"
    end
    if route.number !~ ROUTE_NUMBER_PATTERN
      raise "Route number should contain letters, numbers or hyphens!"
    end
    true
  end

  def train_validate(train)
    if train.number.nil?
      raise "Train number can't be nil!"
    end
    if train.number !~ TRAIN_NUMBER_PATTERN
      raise "Train number should conform to the established mask!"
    end
    true
  end

  def wagon_validate(wagon)
    if wagon.number.nil?
      raise "Wagon number can't be nil!"
    end
    if wagon.number !~ WAGON_NUMBER_PATTERN
      raise "Wagon number should conform to the established mask!"
    end
    true
  end
end
