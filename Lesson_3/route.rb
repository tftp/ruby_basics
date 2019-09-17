class Route
  attr_accessor :stations

  def initialize(begin_st,end_st)
    @stations = []
    @stations << begin_st << end_st
  end


  def route_add(station)
      self.stations.insert(-2, station)
  end

  def route_del(station)
    self.stations.delete_at(station-1) if station > 1 && station < self.stations.count
  end

  def list
    self.stations.each.with_index(1) do |station, index|
      puts "#{index}. #{station}"
    end
  end

end
