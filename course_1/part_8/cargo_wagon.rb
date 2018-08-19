class CargoWagon < Wagon
  attr_reader :type, :volume
  attr_accessor :free_volume
  def initialize(number, volume)
    super
    @type = "Cargo"
    @volume = volume
    @free_volume = volume
  end

  def take_volume(cargo_volume)
    self.free_volume -= cargo_volume
  end

  def filled_volume
    volume - free_volume
  end
end
