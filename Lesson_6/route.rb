class Route
  include InstanceCounter
  include Validate

  attr_accessor :stations, :number

  def initialize(begin_station, end_station, number)
    @stations = [begin_station, end_station]
    validate!
    @number = number
    register_instance
  end


  def add_station(station)
    stations.insert(-2, station) if station != stations.first && station != stations.last
  end

  def del_station(station)
    stations.delete(station) if station != stations.first && station != stations.last
  end

  def list
    self.stations.each do |station|
      print "--#{station.name}--"
    end
    puts
  end

  def validate!
    if @stations.first.nil? || @stations.last.nil?
      raise "Введено неправильное значение станций!!!\n\n"
    end
  end

end
