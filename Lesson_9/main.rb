# frozen_string_literal: true

require_relative 'company_name'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'train'
require_relative 'train_pass'
require_relative 'train_cargo'
require_relative 'wagon'
require_relative 'wagon_pass'
require_relative 'wagon_cargo'
require_relative 'station'
require_relative 'route'

MENU = { 1 => :menu_1, 2 => :menu_2, 3 => :menu_3 }.freeze
MENU_1 = { 1 => :make_stations,
           2 => :make_rout,
           3 => :make_wagon,
           4 => :make_train }.freeze
MENU_2 = { 1 => :add_station_to_route,
           2 => :del_station_from_route,
           3 => :add_route_to_train,
           4 => :add_wagon_to_train,
           5 => :del_wagon_from_train,
           6 => :volume_wagon,
           7 => :moving_train }.freeze
MENU_3 = { 1 => :info_from_stations,
           2 => :info_from_trains,
           3 => :info_trains,
           4 => :info_wagons }.freeze

class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
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
      variant = gets.chomp.to_i
      MENU[variant] ? send(MENU[variant]) : break
    end
  end

  def data_test
    @stations << Station.new('A') << Station.new('B') << Station.new('C')
    @routes << Route.new(stations.first, stations.last, '100')
    @routes.first.add_station(@stations[1])
    ('001'..'003').each { |number| @wagons << WagonCargo.new(number, rand(10..50)) }
    ('004'..'006').each { |number| @wagons << WagonPass.new(number, rand(10..50)) }
    @trains << TrainCargo.new('qwe01') << TrainCargo.new('qwe02')
    @trains << TrainPass.new('qwe03') << TrainPass.new('qwe04')
    @trains.each { |train| train.add_route(@routes.first) }
    6.times { |i| @trains[rand(0..3)].wagon_add(@wagons[i]) }
  end

  private

  def menu_1
    loop do
      puts 'Введите 1, чтобы создать станцию'
      puts 'Введите 2, чтобы создать маршрут'
      puts 'Введите 3, чтобы создать вагон'
      puts 'Введите 4, чтобы создать поезд'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp.to_i
      MENU_1[variant] ? send(MENU_1[variant]) : break
    end
  end

  def menu_2
    loop do
      puts 'Введите 1, чтобы добавить станцию в маршрут'
      puts 'Введите 2, чтобы удалить станцию из маршрута'
      puts 'Введите 3, чтобы добавить маршрут поезду'
      puts 'Введите 4, чтобы добавить вагон к поезду'
      puts 'Введите 5, чтобы отцепить вагон от поезда'
      puts 'Введите 6, чтобы занять место или объем в вагоне'
      puts 'Введите 7, чтобы переместить поезд по маршруту'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp.to_i
      MENU_2[variant] ? send(MENU_2[variant]) : break
    end
  end

  def menu_3
    loop do
      puts "\nВывод данных об объектах."
      puts 'Введите 1, для вывода списка поездов на станциях'
      puts 'Введите 2, для вывода списка вагонов у поездов'
      puts 'Введите 3, для вывода списка поездов по номеру станции'
      puts 'Введите 4, для вывода списка вагонов по номеру поезда'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp.to_i
      MENU_3[variant] ? send(MENU_3[variant]) : break
    end
  end

  def info_trains
    list_station
    print 'Введите название станции: '
    station_name = gets.chomp
    station = @stations.find { |object| object.name == station_name } if @stations
    return unless validate?(station)

    station.each_train do |object|
      print "Номер поезда:#{object.number}, тип:#{object.type}, "
      puts "количество вагонов:#{object.wagons.count}"
    end
  end

  def info_wagons
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда: '
    number_train = gets.chomp
    train = @trains.find { |object| object.number == number_train } if @trains
    return unless validate?(train)

    train.each_wagon do |object|
      print "Номер вагона:#{object.number}, тип:#{object.type}, "
      print "свободный объем: #{object.free_volume}, " if object.type == :cargo
      print "занятый объем: #{object.held_volume} \n" if object.type == :cargo
      print "свободных мест: #{object.free_volume}, " if object.type == :pass
      print "занятых мест: #{object.held_volume} \n" if object.type == :pass
    end
  end

  def info_from_stations
    Station.block_processing do |object|
      print "Номер поезда:#{object.number}, тип:#{object.type}, "
      puts "количество вагонов:#{object.wagons.count}"
    end
  end

  def info_from_trains
    Train.block_processing do |object|
      print "Номер вагона:#{object.number}, тип:#{object.type}, "
      print "свободный объем: #{object.free_volume}, " if object.type == :cargo
      print "занятый объем: #{object.held_volume} \n" if object.type == :cargo
      print "свободных мест: #{object.free_volume}, " if object.type == :pass
      print "занятых мест: #{object.held_volume} \n" if object.type == :pass
    end
  end

  def add_station_to_route
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута в который добавить станцию: '
    number = gets.chomp
    route = @routes.find { |rout| rout.number == number } if @routes
    return unless validate?(route)

    list_station
    print "\nВведите название станции для добавления: "
    station_between = gets.chomp
    station = @stations.find { |object| object.name == station_between } if @stations
    return unless validate?(station)

    puts "Станция #{station_between} добавлена." if route.add_station(station)
  end

  def del_station_from_route
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута из которого удалить станцию: '
    number = gets.chomp
    route = @routes.find { |rout| rout.number == number } if @routes
    return unless validate?(route)

    print 'Введите название станции для удаления: '
    station_between = gets.chomp
    station = @stations.find { |object| object.name == station_between } if @stations
    return unless validate?(station)

    puts "Станция #{station_between} удалена." if route.del_station(station)
  end

  def add_route_to_train
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута для добавления поезду: '
    number_route = gets.chomp
    route = @routes.find { |rout| rout.number == number_route } if @routes
    return unless validate?(route)

    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для добавления маршрута: '
    number_train = gets.chomp
    train = @trains.find { |object| object.number == number_train } if @trains
    return unless validate?(train)

    train.add_route(route)
    puts 'Маршрут добавлен.'
  end

  def add_wagon_to_train
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для добавления вагона: '
    number_train = gets.chomp
    train = @trains.find { |object| object.number == number_train } if @trains
    return unless validate?(train)

    puts 'Доступны следующие вагоны: '
    @wagons.each { |wagon| print " #{wagon.number} " if wagon.train.empty? }
    print "\nВведите номер вагона: "
    number_wagon = gets.chomp
    wagon = @wagons.find { |object| object.number == number_wagon } if @wagons
    return unless validate?(wagon)

    if train.type == wagon.type && train.wagon_add(wagon)
      puts 'Вагон добавлен'
    else
      puts 'Вагон не добавлен'
    end
  end

  def del_wagon_from_train
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для удаления вагона: '
    number_train = gets.chomp
    train = @trains.find { |object| object.number == number_train } if @trains
    return unless validate?(train)

    puts 'Доступны следующие вагоны: '
    train.wagons.each { |wagon| print " #{wagon.number} " }
    print "\nВведите номер вагона: "
    number_wagon = gets.chomp
    wagon = @wagons.find { |object| object.number == number_wagon } if @wagons
    return unless validate?(wagon)

    if train.type == wagon.type && train.wagon_del(wagon)
      puts 'Вагон удален'
    else
      puts 'Вагон не удален'
    end
  end

  def volume_wagon
    puts 'Для заполнения доступны следующие вагоны:'
    print 'Cargo: '
    Wagon.all.each { |key, volume| print " #{key}" if volume.type == :cargo }
    print "\nPassenger: "
    Wagon.all.each { |key, volume| print " #{key}" if volume.type == :pass }
    print "\nВведите номер вагона для заполнения: "
    wagon = Wagon.all[gets.chomp]
    return unless validate? wagon

    wagon.type == :cargo ? volume_wagon_cargo(wagon) : volume_wagon_pass(wagon)
  end

  def volume_wagon_cargo(object)
    puts "\nСвободное место в вагоне составляет #{object.free_volume}"
    puts "Заполненное пространство в вагоне составляет #{object.held_volume}"
    print 'Введите данные для заполнения вагона: '
    volume = gets.chomp.to_i
    object.add_cargo(volume)
    print "\nИтого свободное/заполненное пространство в вагоне состaвляет "
    puts "#{object.free_volume}/#{object.held_volume}"
    gets
  end

  def volume_wagon_pass(object)
    puts "\nСвободное место в вагоне составляет #{object.free_volume}"
    puts "Заполненное пространство в вагоне составляет #{object.held_volume}"
    print 'Введите 1 для заполнения вагона или другую клавишу для выхода: '
    variant = gets.chomp.to_i
    object.add_passenger if variant == 1
    print "\nИтого свободное/заполненное пространство в вагоне состовляет "
    puts "#{object.free_volume}/#{object.held_volume}"
    gets
  end

  def moving_train
    puts 'Доступны следующие поезда:'
    @trains.each { |train| puts " Номер: #{train.number}" if train.current_station }
    print 'Введите номер поезда для отправления: '
    number_train = gets.chomp
    train = @trains.find { |object| object.number == number_train } if @trains
    return unless validate?(train)

    loop do
      train.what_station
      puts 'Введите 1 для отправления поезда вперед'
      puts 'Введите 2 для отправления поезда назад'
      puts 'Введите 0 для выхода в предыдущее меню'
      return unless (variant = gets.chomp.to_i).between?(1, 2)

      if variant == 1
        train.route_forward
      else
        train.route_backward
      end
    end
  end

  def list_station
    print 'Доступны следующие станции: '
    if @stations.empty?
      print 'нет доступных станций.'
    else
      @stations.each { |station| print " #{station.name} " }
    end
  end

  def list_object(array_object)
    array_object.each do |object|
      print "#{object}: "
      print " Номер: #{object.number}. " if object.methods.include?(:number)
      print " Тип: #{object.type}. " if object.methods.include?(:type)
      object.list if object.methods.include?(:list)
      puts
    end
  end

  def make_train
    puts 'Введите 1 для создания грузового поезда'
    puts 'Введите 2 для создания пассажирского поезда'
    return unless (variant = gets.chomp.to_i).between?(1, 2)

    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      @trains << (variant == 1 ? TrainCargo.new(number) : TrainPass.new(number))
      puts "Поезд номером: #{number} создан"
      gets
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def make_wagon
    puts 'Введите 1 для создания грузового вагона'
    puts 'Введите 2 для создания пассажирского вагона'
    return unless (variant = gets.chomp.to_i).between?(1, 2)

    begin
      puts 'Введите номер вагона'
      number = gets.chomp
      if variant == 1
        puts 'Введите максимальный объем груза:'
        @wagons << WagonCargo.new(number, gets.chomp.to_i)
      else
        puts 'Введите максимальное количество пассажиров:'
        @wagons << WagonPass.new(number, gets.chomp.to_i)
      end
      puts "Вагон #{number} создан"
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def make_stations
    print 'Сколько станций создать? '
    number = gets.chomp.to_i
    (1..number).each do |station_number|
      begin
        print "Введите название #{station_number} станции: "
        name = gets.chomp
        @stations << Station.new(name)
        puts "Станция #{name} создана"
      rescue StandardError => e
        puts e.message
        retry
      end
    end
  end

  def make_rout
    list_station
    begin
      print "\nВведите начальную станцию маршрута: "
      first_station = gets.chomp
      first_station = @stations.find { |station| station.name == first_station }
      print 'Введите конечную станцию маршрута: '
      last_station = gets.chomp
      last_station = @stations.find { |station| station.name == last_station }
      @routes << Route.new(first_station, last_station, Time.now.sec.to_s)
      puts "Маршрут создан\n"
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def validate!(data)
    raise "Неправильный ввод данных!!!\n\n" if data.nil?
  end

  def validate?(data)
    validate!(data)
    true
  rescue StandardError => e
    puts e.message
    false
  end
end
