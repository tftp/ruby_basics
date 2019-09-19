class Train
  attr_accessor :speed, :wagons
  attr_reader :type, :number, :stat_cur

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = []
    @index
    @stat_cur
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
    @stat_cur = @route[@index]
    @stat_cur.train_out(self)
    @stat_cur.train_in(self)
  end

  def route_forward
    return if @route.empty?
    @index += 1 if @index < @route.count - 1
    @stat_cur.train_out(self)
    @stat_cur = @route[@index]
    @stat_cur.train_in(self)
  end

  def route_backward
    return if @route.empty?
    @index -= 1 if @index > 0
    @stat_cur.train_out(self)
    @stat_cur = @route[@index]
    @stat_cur.train_in(self)
  end

  def what_station
    return if @route.empty?
    case @index
    when 0
      puts "Поезд на #{@index+1} станции: #{@stat_cur.name}"
      puts "Седующая станция: #{@route[1].name}"
    when @route.count - 1
      puts "Поезд на последней станции: #{@stat_cur.name}"
      puts "Предыдущая станция: #{@route[-2].name}"
    else
      puts "Поезд на #{@index+1} станции: #{@stat_cur.name}"
      puts "Предыдущая станция: #{@route[@index - 1].name}"
      puts "Седующая станция: #{@route[@index + 1].name}"
    end
  end

end
