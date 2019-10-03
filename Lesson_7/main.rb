require_relative 'company_name'
require_relative 'validate'
require_relative 'instance_counter'
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

  private
 #Нижестоящие методы испоьзуем только в классе RailRoad

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
          variant = gets.chomp.to_i
          make_wagon(variant) if variant.between?(1, 2)
        when '4'
          #создание поезда
          puts 'Введите 1 для создания грузового поезда'
          puts 'Введите 2 для создания пассажирского поезда'
          variant = gets.chomp.to_i
          make_train(variant) if variant.between?(1, 2)
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
      puts 'Введите 6, чтобы занять место или объем в вагоне'
      puts 'Введите 7, чтобы переместить поезд по маршруту'
      puts 'Введите 0, чтобы выти на уровень вверх'
      variant = gets.chomp
      case variant
        when '1'
          add_station_to_route
        when '2'
          del_station_from_route
        when '3'
          add_route_to_train
        when '4'
          add_wagon_to_train
        when '5'
          del_wagon_from_train
        when '6'
          volume_wagon
        when '7'
          moving_train
        when '0'
          break
      end
    end
  end

  def menu_3
    puts "\nВывод данных об объектах."
    list_station
    print "\nВведите название станции, что бы увидеть список поездов на станции: "
    station_name = gets.chomp
    station = @stations.find{|station| station.name == station_name} if @stations
    return unless validate?(station)
    if station.trains.empty?
      puts "\nНет поездов на станции #{station.name}"
    else
      station.output if station
    end
  end

  def add_station_to_route
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута в который добавить станцию: '
    number = gets.chomp
    route = @routes.find{|rout| rout.number == number} if @routes
    return unless validate?(route)
    list_station
    print 'Введите название станции для добавления: '
    station_between = gets.chomp
    station = @stations.find{|station| station.name == station_between} if @stations
    return unless validate?(station)
    route.add_station(station)
    puts "Станция #{station_between} добавлена."
  end

  def del_station_from_route
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута из которого удалить станцию: '
    number = gets.chomp
    route = @routes.find{|rout| rout.number == number} if @routes
    return unless validate?(route)
    print 'Введите название станции для удаления: '
    station_between = gets.chomp
    station = @stations.find{|station| station.name == station_between} if @stations
    return unless validate?(station)
    if route.del_station(station)
      puts "Станция #{station_between} удалена."
    else
      puts 'Станция не удалена.'
    end
  end

  def add_route_to_train
    puts 'Доступны следующие маршруты:'
    list_object(@routes)
    print 'Введите номер маршрута для добавления поезду: '
    number_route = gets.chomp
    route = @routes.find{|rout| rout.number == number_route} if @routes
    return unless validate?(route)
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для добавления маршрута: '
    number_train = gets.chomp
    train = @trains.find{|train| train.number == number_train} if @trains
    return unless validate?(train)
    if train.add_route(route)
      puts 'Маршрут добавлен.'
    else
      puts "Маршрут не добавлен."
    end
  end

  def add_wagon_to_train
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для добавления вагона: '
    number_train = gets.chomp
    train = @trains.find{|train| train.number == number_train} if @trains
    return unless validate?(train)
    puts 'Доступны следующие вагоны: '
    @wagons.each {|wagon| print " #{wagon.number} " if wagon.train.empty?}
    print "\nВведите номер вагона: "
    number_wagon = gets.chomp
    wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
    return unless validate?(wagon)
    if train.type == wagon.type && train.wagon_add(wagon)
      puts "Вагон добавлен"
    else
      puts "Вагон не добавлен"
    end
  end

  def del_wagon_from_train
    puts 'Доступны следующие поезда:'
    list_object(@trains)
    print 'Введите номер поезда для удаления вагона: '
    number_train = gets.chomp
    train = @trains.find{|train| train.number == number_train} if @trains
    return unless validate?(train)
    puts 'Доступны следующие вагоны: '
    train.wagons.each {|wagon| print " #{wagon.number} "}
    print "\nВведите номер вагона: "
    number_wagon = gets.chomp
    wagon = @wagons.find{|wagon| wagon.number == number_wagon} if @wagons
    return unless validate?(wagon)
    if train.type == wagon.type && train.wagon_del(wagon)
      puts "Вагон удален"
    else
      puts "Вагон не удален"
    end
  end

  def volume_wagon
    puts 'Заполняем вагон'
    puts 'Доступны следующие вагоны:'
    print 'Cargo: '
    Wagon.all.each{|key, volume| print " #{key}" if volume.type == :cargo}
    print "\nPassenger: "
    Wagon.all.each{|key, volume| print " #{key}" if volume.type == :pass}
    print "\nВведите номер вагона для заполнения: "
    number = gets.chomp
    wagon = Wagon.all[number]
    return unless validate? (wagon)
    case wagon.type
      when :cargo
        puts "\nСвободное место в вагоне составляет #{wagon.free_volume}"
        puts "Заполненное пространство в вагоне составляет #{wagon.held_volume}"
        print "Введите данные для заполнения вагона: "
        volume = gets.chomp.to_i
        wagon.add_cargo(volume)
        puts "\nИтого свободное/заполненное пространство в вагоне состовляет #{wagon.free_volume}/#{wagon.held_volume}"
        gets
      when :pass
        puts "\nСвободное место в вагоне составляет #{wagon.free_volume}"
        puts "Заполненное пространство в вагоне составляет #{wagon.held_volume}"
        print "Введите 1 для заполнения вагона или другую клавишу для выхода без заполнения: "
        variant = gets.chomp.to_i
        wagon.add_passenger if variant == 1
        puts "\nИтого свободное/заполненное пространство в вагоне состовляет #{wagon.free_volume}/#{wagon.held_volume}"
        gets
    end
  end

  def moving_train
    puts 'Доступны следующие поезда:'
    @trains.each{|train| puts " Номер: #{train.number}" if train.current_station}
    print 'Введите номер поезда для отправления: '
    number_train = gets.chomp
    train = @trains.find{|train| train.number == number_train} if @trains
    return unless validate?(train)
    loop do
      train.what_station
      puts 'Введите 1 для отправления поезда вперед'
      puts 'Введите 2 для отправления поезда назад'
      puts 'Введите 0 для выхода в предыдущее меню'
      variant = gets.chomp
      case variant
        when '1'
          train.route_forward
        when '2'
          train.route_backward
        else
          break
      end
    end
  end

  def list_station
    print 'Доступны следующие станции: '
    if @stations.empty?
      print 'нет доступных станций.'
    else
      @stations.each {|station| print " #{station.name} "}
    end
    puts
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

  def make_train(variant)
    begin
      puts 'Введите номер поезда'
      number = gets.chomp
      case variant
        when 1
          @trains << TrainCargo.new(number)
        when 2
          @trains << TrainPass.new(number)
      end
      puts "Поезд номером: #{number} создан"
      gets
    rescue => e
      puts e.message
      retry
    end
  end

  def make_wagon(variant)
    begin
      puts 'Введите номер вагона'
      number = gets.chomp
      case variant
        when 1
          puts 'Введите максимальный объем груза:'
          amount = gets.chomp.to_i
          @wagons << WagonCargo.new(number, amount)
        when 2
          puts 'Введите максимальное количество пассажиров:'
          amount = gets.chomp.to_i
          @wagons << WagonPass.new(number, amount)
        else
          return
      end
      puts "Вагон #{number} создан"
      gets
    rescue => e
      puts e.message
      retry
    end
  end

  def make_stations
    print 'Сколько станций создать? '
    number = gets.chomp.to_i
    for station_number in (1..number)
      begin
        print "Введите название #{station_number} станции: "
        name = gets.chomp
        @stations << Station.new(name)
        puts "Станция #{name} создана"
        gets
      rescue => e
        puts e.message
        retry
      end
    end
  end

  def make_rout
    begin
      print "\nВведите начальную станцию маршрута: "
      first_station = gets.chomp
      first_station = @stations.find{|station| station.name == first_station}
      print 'Введите конечную станцию маршрута: '
      last_station = gets.chomp
      last_station = @stations.find{|station| station.name == last_station}
#      return puts 'Такой маршрут уже есть!' if @routes.find{|rout| rout.stations.first == first_station && rout.stations.last == last_station} if @routes
      number = Time.now.sec.to_s
      @routes << Route.new(first_station, last_station, number)
      puts "Маршрут создан"
    rescue => e
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
  rescue => e
    puts e.message
    false
  end

end
