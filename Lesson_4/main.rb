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
          number = gets.chomp
          list_station
          print 'Введите название станции для добавления: '
          station_between = gets.chomp
          station_between = @stations.find{|station| station.name == station_between}
          route = @routes.find{|rout| rout.number == number} if @routes
          if route
            route.add_station(station_between)
            puts 'Станция добавлена.'
          else
            puts 'Станция не добавлена.'
          end
        when '2'
          puts 'Доступны следующие маршруты:'
          list_object(@routes)
          print 'Введите номер маршрута из которого удалить станцию: '
          number = gets.chomp
#          list_station
          print 'Введите название станции для удаления: '
          station_between = gets.chomp
          station_between = @stations.find{|station| station.name == station_between}
          route = @routes.find{|rout| rout.number == number} if @routes
          if route && route.del_station(station_between)
            puts 'Станция удалена.'
          else
            puts 'Станция не удалена.'
          end
        when '3'
          puts 'Доступны следующие маршруты:'
          list_object(@routes)
          print 'Введите номер маршрута для добавления поезду: '
          number_route = gets.chomp
          puts 'Доступны следующие поезда:'
          list_object(@trains)
          print 'Введите номер поезда для добавления маршрута: '
          number_train = gets.chomp
          route = @routes.find{|rout| rout.number == number_route} if @routes
          train = @trains.find{|train| train.number == number_train} if @trains
          if route && train && train.add_route(route)
            puts 'Маршрут добавлен.'
          else
            puts "Маршрут не добавлен. #{route} #{train}"
          end
        when '4'
          puts 'Доступны следующие поезда:'
          list_object(@trains)
          print 'Введите номер поезда для добавления вагона: '
          number_train = gets.chomp
          train = @trains.find{|train| train.number == number_train} if @trains
          puts 'Доступны следующие вагоны: '
          list_object(@wagons)
          print 'Введите номер вагона: '
          number_wagon = gets.chomp
          wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
          if train && wagon && train.type == wagon.type && train.wagon_add(wagon)
            puts "Вагон добавлен"
          else
            puts "Вагон не добавлен"
          end
        when '5'
          puts 'Доступны следующие поезда:'
          list_object(@trains)
          print 'Введите номер поезда для удаления вагона: '
          number_train = gets.chomp
          train = @trains.find{|train| train.number == number_train} if @trains
          puts 'Доступны следующие вагоны: '
          train.wagons.each {|wagon| print " #{wagon.number} "}
          print "\nВведите номер вагона: "
          number_wagon = gets.chomp
          wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
          if train && wagon && train.type == wagon.type && train.wagon_del(wagon)
            puts "Вагон удален"
          else
            puts "Вагон не удален"
          end
        when '6'
          puts 'Доступны следующие поезда:'
          @trains.each{|train| puts " Номер: #{train.number}" if train.curr_station}
          print 'Введите номер поезда для отправления: '
          number_train = gets.chomp
          train = @trains.find{|train| train.number == number_train} if @trains
          if train
            loop do
              puts "Поезд находится на станции: #{train.curr_station.name}"
              puts 'Введите 1 для отправления поезда вперед'
              puts 'Введите 2 для отправления поезда назад'
              puts 'Введите 0 для выхода в предыдущее меню'
              variant = gets.chomp
              case variant
                when '1'
                  train.route && train.route_forward
                when '2'
                  train.route && train.route_backward
                when '0'
                  break
              end
            end
          end
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
      arr_object.each do |object|
        print "#{object}: "
        print " Номер: #{object.number}. " if object.methods.include?(:number)
        print " Тип: #{object.type}. " if object.methods.include?(:type)
        object.list if object.methods.include?(:list)
        puts
      end
  end

  def make_train(variant)
    puts 'Введите номер поезда'
    number = gets.chomp
    case variant
      when '1'
        unless @trains.find{|train| train.number == number}
          @trains << TrainCargo.new(number)
          puts "Поезд создан"
        else
          puts "Поезд не создан"
        end
      when '2'
        unless @trains.find{|train| train.number == number}
          @trains << TrainPass.new(number)
          puts "Поезд создан"
        else
          puts "Поезд не создан"
        end
    end
  end

  def make_wagon(variant)
    puts 'Введите номер вагона'
    number = gets.chomp
    case variant
      when '1'
        unless @wagons.find{|wagon| wagon.number == number}
          @wagons << WagonCargo.new(number)
          puts "Вагон создан"
        else
          puts "Вагон не создан"
        end
      when '2'
        unless @wagons.find{|wagon| wagon.number == number}
          @wagons << WagonPass.new(number)
          puts "Вагон создан"
        else
          puts "Вагон не создан"
        end
    end
  end

  def make_stations
    print 'Сколько станций создать? '
    number = gets.chomp.to_i
    for station_number in (1..number)
      print "Введите название #{station_number} станции: "
      name = gets.chomp
      unless @stations.find{|station| station.name == name}
        @stations << Station.new(name)
        puts "Станция создана"
      else
        puts "Станция не создана"
      end
    end
  end

  def make_rout
    print "\nВведите начальную станцию маршрута: "
    first_station = gets.chomp
    first_station = @stations.find{|station| station.name == first_station}
    print 'Введите конечную станцию маршрута: '
    last_station = gets.chomp
    last_station = @stations.find{|station| station.name == last_station}
    return puts 'Маршрут не создан ' if last_station.nil? || first_station.nil?
    number = Time.now.sec.to_s
    @routes << Route.new(first_station, last_station, number)
    puts "Машрут создан"
  end

end
