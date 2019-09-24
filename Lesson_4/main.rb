require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'
require_relative 'station'
require_relative 'route'

class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations =[]
    @trains = []
    @routes = []
    @wagons = []
  end

  def menu
    loop do
      puts 'Симулятор железной дороги'
      puts 'Введите 1, если хотите создать станцию, поезд, вагон или маршрут'
      puts 'Введите 2, если хотите произвести операции с созданными объектами'
      puts 'Введите 3, если хотите вывести текущие данные об объектах'
      puts 'Введите 0, если хотите закончить программу'
      variant = gets.chomp
      case variant
        when '1'
          #создаем станцию, поезд, вагон, маршрут
          menu_1
        when '2'
          #операции с объектами
          menu_2
        when '3'
          #вывод данных об объектах
          menu_3
        when '0'
          break
      end
    end
  end

  def menu_1
    loop do
      puts 'Введите 1, чтобы создать станцию'
      puts 'Введите 2, чтобы создать маршрут'
      puts 'Введите 3, чтобы создать вагон'
      puts 'Введите 4, чтобы создать поезд'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp
      case variant
        when '1'
          #создание станции
          make_stations
          puts
        when '2'
          #создание маршрута
          list_station
          make_rout
          puts
        when '3'
          #создание вагона
          puts 'Введите 1 для создания грузового вагона'
          puts 'Введите 2 для создания пассажирского вагона'
          variant = gets.chomp
          make_wagon(variant)
        when '4'
          #создание поезда
          puts 'Введите 1 для создания грузового поезда'
          puts 'Введите 2 для создания пассажирского поезда'
          variant = gets.chomp
          make_train(variant)
        when '0'
          #выход на предыдущийс уровень
          break
      end
    end
  end

  def menu_2
    loop do
      puts 'Введите 1, чтобы добавить станцию в маршрут'
      puts 'Введите 2, чтобы удалить станцию из маршрута'
      puts 'Введите 3, чтобы добавить маршрут поезду'
      puts 'Введите 4, чтобы добавить вагон к поезду'
      puts 'Введите 5, чтобы отцепить вагон от поезда'
      puts 'Введите 6, чтобы переместить поезд по маршруту'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp
      case variant
        when '1'
          puts 'Доступны следующие маршруты:'
          list_object(@routes)
          print 'Введите номер маршрута в который добавить станцию: '
          variant = gets.chomp.to_i
          list_station
          print 'Введите название станции для добавления: '
          station_between = gets.chomp
          station_between = @stations.select{|station| station.name == station_between}[0]
          if (@routes[variant - 1].add_station(station_between) unless variant.zero? || station_between.nil?)
            puts 'Станция добавлена.' 
          else
            puts 'Станция не добавлена.'
          end
        when '2'
          puts 'Доступны следующие маршруты:'
          list_object(@routes)
          print 'Введите номер маршрута из которого удалить станцию: '
          variant = gets.chomp.to_i
          list_station
          print 'Введите название станции для удаления: '
          station_between = gets.chomp
          station_between = @stations.select{|station| station.name == station_between}[0]
          if (@routes[variant - 1].del_station(station_between) unless variant.zero? || station_between.nil?)
            puts 'Станция удалена.' 
          else
            puts 'Станция не удалена.'
          end
        when '3'
        when '4'
        when '5'
        when '6'
        when '0'
          break
      end
    end

  end

  def data_clear
    @stations =[]
    @trains = []
    @routes = []
    @wagons = []
  end

  private

  def list_station
    print 'Доступны следующие станции для маршрута: '
    if @stations.empty?
      print 'нет доступных станций.'
    else
      @stations.each {|station| print " #{station.name} "}
    end
    puts
  end

  def list_object(arr_object)
    arr_object.each.with_index(1) do |object, index|
      print "#{index}. #{object}: "
      object.list if object.methods.include?(:list)
      puts
    end
  end

  def make_train(variant)
    puts 'Введите номер поезда'
    number = gets.chomp
    case variant
      when '1'
        @trains << TrainCargo.new(number)
      when '2'
        @trains << TrainPass.new(number)
    end
  end

  def make_wagon(variant)
    puts 'Введите номер вагона'
    number = gets.chomp
    case variant
      when '1'
        @wagons << WagonCargo.new(number)
      when '2'
        @wagons << WagonPass.new(number)
    end
  end

  def make_stations
    print 'Сколько станций создать? '
    number = gets.chomp.to_i
    for station_number in (1..number)
      print "Введите название #{station_number} станции: "
      name = gets.chomp
      @stations << Station.new(name)
    end
  end

  def make_rout
    print "\nВведите начальную станцию маршрута: "
    first_station = gets.chomp
    first_station = @stations.select{|station| station.name == first_station}[0]
    print 'Введите конечную станцию маршрута: '
    last_station = gets.chomp
    last_station = @stations.select{|station| station.name == last_station}[0]
    @routes << Route.new(first_station, last_station)
  end

end
