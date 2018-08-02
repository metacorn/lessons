class Wagon
  attr_reader :number, :type
  def initialize(number, type)
    @number = number
    @type = type
  end

  def free?
    $trains_list.each do |train|
      if train.wagons.include? self
        return false
        break
      end
      true
    end
  end
end
