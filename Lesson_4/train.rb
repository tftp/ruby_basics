class Train
  attr_accessor :speed, :wagons
  attr_reader :type, :number, :current_station

  def initialize(number)
    @number = number
    @type
    @wagons = []
    @speed = 0
    @route
    @current_station
  end

  def wagon_add (wagon)
    if self.speed == 0
      self.wagons << wagon
      wagon.train_in(self)
    end
  end

  def wagon_del (wagon)
    if self.speed == 0
      self.wagons.delete(wagon)
      wagon.train_out(self)
    end
  end

  def add_route (route)
    @route = route
    @current_station = @route.stations[0]
    @current_station.train_in(self)
  end

  def route_forward
    return unless next_stat
    @current_station.train_out(self)
    @current_station = next_stat
    @current_station.train_in(self)
  end

  def route_backward
    return unless prev_stat
    @current_station.train_out(self)
    @current_station = prev_stat
    @current_station.train_in(self)
  end

  private
  #нижестоящие методы пока не используются

  def next_stat
    @route.stations[@route.stations.index(@current_station) + 1]
  end

  def prev_stat
    unless @route.stations.index(@current_station) - 1 == - 1
      @route.stations[@route.stations.index(@current_station) - 1]
    end
  end

  def speed_up(speed = 5)
    self.speed += speed
  end

  def speed_down
    self.speed = 0
  end

  def what_station
    return if @route.stations.empty?
      puts "Поезд на станции: #{@current_station.name}"
      puts "Предыдущая станция: #{prev_stat ? prev_stat.name : 'нет станций'}"
      puts "Седующая станция: #{next_stat ? next_stat.name : 'нет станций' }"
  end

end
