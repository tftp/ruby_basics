# frozen_string_literal: true

class Route
  extend Validation

  include InstanceCounter
#  include Validate

  attr_accessor :stations, :number

  def initialize(begin_station, end_station, number)
    @begin_station = begin_station
    @end_station = end_station
    @stations = [@begin_station, @end_station]
    @number = number
    self.class.validate :begin_station, :presence
    self.class.validate :end_station, :presence
    validate!
    register_instance
  end

  def add_station(station)
    return if stations.first.include?(station) || stations.last.include?(station)

    stations.insert(-2, station)
  end

  def del_station(station)
    return if stations.first.include?(station) || stations.last.include?(station)

    stations.delete(station)
  end

  def list
    stations.each do |station|
      print "--#{station.name}--"
    end
    puts
  end

#  def validate!
#    return unless @stations.first.nil? || @stations.last.nil?
#
#    raise "Введено неправильное значение станций!!!\n\n"
#  end
end
