class Route
  attr_accessor :stations, :number

  def initialize(begin_st, end_st, number)
    @stations = [begin_st, end_st]
    @number = number
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

end
