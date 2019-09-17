class Train
  attr_accessor :speed, :wagons

  def initialize(number, type, wagons)
    @number = number
    type['пассажирский'] ? @type = 'пассажирский' : @type = 'грузовой'
    @wagons = wagons
    @speed = 0
    @route = []
    @index
  end

  def speed_up(speed = 5)
    self.speed += speed
  end

  def speed_down
    self.speed = 0
  end

  def wagon_count
    self.wagons
  end

  def change_wagons(add = -1)
    add = 1 if add != -1
    self.wagons += add if self.speed == 0
  end

  def add_route (route)
    @route = route.stations
    @index = 0
  end

  def route_forward
    return if @route.empty?
    @index += 1 if @index < @route.count - 1
  end

  def route_backward
    return if @route.empty?
    @index -= 1 if @index > 0
  end

  def what_station
    return if @route.empty?
    case @index
    when 0
      puts "Поезд на #{@index+1} станции: #{@route[0]}"
      puts "Седующая станция: #{@route[1]}"
    when @route.count - 1
      puts "Поезд на последней станции: #{@route[-1]}"
      puts "Предыдущая станция: #{@route[-2]}"
    else
      puts "Поезд на #{@index+1} станции: #{@route[@index]}"
      puts "Предыдущая станция: #{@route[@index - 1]}"
      puts "Седующая станция: #{@route[@index + 1]}"
    end
  end

end
