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
    self.wagons -= 1 if self.speed == 0 && !self.wagons.zero?
  end

  def next_stat
    @route.stations[@route.stations.index(@curr_station) + 1]
  end

  def prev_stat
    unless @route.stations.index(@curr_station) - 1 == - 1
      @route.stations[@route.stations.index(@curr_station) - 1]
    else
      nil
    end
  end

  def add_route (route)
    @route = route
    @curr_station = @route.stations[0]
    @curr_station.train_in(self)
  end

  def route_forward
    return unless next_stat
    @curr_station.train_out(self)
    @curr_station = next_stat
    @curr_station.train_in(self)
  end

  def route_backward
    return unless prev_stat
    @curr_station.train_out(self)
    @curr_station = prev_stat
    @curr_station.train_in(self)
  end

  def what_station
    return if @route.stations.empty?
      puts "Поезд на станции: #{@curr_station.name}"
      puts "Предыдущая станция: #{prev_stat ? prev_stat.name : 'нет станций'}"
      puts "Седующая станция: #{next_stat ? next_stat.name : 'нет станций' }"
  end

end
