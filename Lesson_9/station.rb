# frozen_string_literal: true

# class Station for stations instance
class Station
  extend Validation

  include InstanceCounter
#  include Validate

  @@all_stations = {}
  VALID_NAME_STATION = /^[a-zA-Z]+\d*$/.freeze

  def self.all
    @@all_stations
  end

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    self.class.validate :name, :presence
    self.class.validate :name, :compare
    self.class.validate :name, :format, VALID_NAME_STATION
    validate!
    @trains = []
    @@all_stations[name] = self
    register_instance
  end

  def self.block_processing
    Station.all.each do |name, station|
      puts "Станция #{name}:"
      station.trains.each { |train| yield(train) }
    end
  end

  def each_train
    trains.each { |train| yield(train) }
  end

  def train_in(train)
    @trains << train
  end

  def train_out(train)
    @trains.delete(train)
  end

  def output
    return if @trains.empty?

    puts "\nСписок поездов на станции  #{@name}:"
    @trains.each do |train|
      print "Поезд номер #{train.number},тип: #{train.type}, коичество вагонов:"
      puts " #{train.wagons.count}"
    end
  end

  protected

#  def validate!
#    raise "Введено неправильное название!\n\n" if name !~ VALID_NAME_STATION
#    raise "Такая станция уже есть!\n\n" if @@all_stations[name]
#  end

  def output_type(type)
    number_type = @trains.count { |train| train.type == type }
    puts "Поездов типа #{type} на станции: #{number_type}"
  end
end
