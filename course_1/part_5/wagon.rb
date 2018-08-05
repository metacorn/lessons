class Wagon
  attr_reader :number, :type
  def initialize(number, type)
    @number = number
    @type = type
  end

  def free?
    $trains_list.each { |train| return false if train.wagons.include?(self) }
    true
  end
end
