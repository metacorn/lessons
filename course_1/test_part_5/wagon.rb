class Wagon
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def free?
    $trains_list.none? { |train| train.wagons.include?(self)}
  end
end
