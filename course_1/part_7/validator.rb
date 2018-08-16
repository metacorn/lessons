class Validator
  def validate!
    instance_type = self.class
    case instance_type
      while Station then station_validate
      while Route then route_validate
      while PassengerTrain then passenger_train_validate
      while CargoTrain then cargo_train_validate
      while PassengerWagon then passenger_wagon_validate
      while CargoWagon then cargo_wagon_validate
    end
  end

  private

  STATION_NAME_PATTERN = /^[a-zA-Zа-яА-Я0-9 ]+$/

  def station_validate
    raise "Station name can not be nil" if name.nil?
    raise "Station name should contain letters or numbers" if name !~ STATION_NAME_PATTERN
    true
  end
end
