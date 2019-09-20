class Train
  attr_accessor :speed, :wagons
  attr_reader :type, :number

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @speed = 0
    @route = []
    @curr_station
    @next_station
    @prev_station
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

  def wagon_add
    self.wagons += 1 if self.speed == 0
  end

  def wagon_del
    self.wagons -= 1 if self.speed == 0
  end

  def next_stat
#    if @route[@route.index(@curr_station) + 1]
      @next_station = @route.rotate(@route.index(@curr_station) + 1)[0]
#    end
  end

  def prev_stat
#    if @route[@route.index(@curr_station) - 1]
     @prev_station = @route.rotate(@route.index(@curr_station) - 1)[0]
#    end
  end

  def add_route (route)
    @route = route.stations
    @curr_station = @route[0]
    prev_stat
    next_stat
    @curr_station.train_in(self)
  end

  def route_forward
    return if @route.empty?
    @curr_station.train_out(self)
    @curr_station = @next_station
    next_stat
    prev_stat
    @curr_station.train_in(self)
  end

  def route_backward
    return if @route.empty?
    @curr_station.train_out(self)
    @curr_station = @prev_station
    next_stat
    prev_stat
    @curr_station.train_in(self)
  end

  def what_station
    return if @route.empty?
      puts "Поезд на станции: #{@curr_station.name}"
      puts "Предыдущая станция: #{@prev_station.name}"
      puts "Седующая станция: #{@next_station.name}"
  end

end
