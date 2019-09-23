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
        when '3'
          #вывод данных об объектах
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
          print 'Сколько станций создать? '
          number = gets.chomp.to_i
          for station_number in (1..number)
            print "Введите название #{station_number} станции: "
            name = gets.chomp
            @stations << Station.new(name)
          end
          puts
        when '2'
          #создание маршрута
          print "Доступны следующие станции для маршрута: "
          if @stations.empty? 
            print "нет доступных станций." 
          else
            @stations.each {|station| print " #{station.name} "}
          end
          
          puts  
        when '3'
          #создание вагона
        when '4'
          #создание поезда
        when '0'
          break
      end
    end

  end

end
