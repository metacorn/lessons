class Wagon
  attr_reader :number
  def initialize(number)
    @number = number
  end

  def free?
    $trains_list.each { |train| return false if train.wagons.include?(self) }
    true
  end
end
