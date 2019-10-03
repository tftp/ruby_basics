class Wagon
  include CompanyName
  include Validate
  
  VALID_NAME_WAGON = /^\d{3}$/
  @@all_wagon = {}
  attr_reader :number, :type, :train, :volume

  def self.all
    @@all_wagon
  end

  def initialize(number, amount)
    @volume = [0, amount]
    @number = number
    validate!
    @train = []
    @@all_wagon[number] = self
  end

  def train_in(train)
    @train << train
  end

  def train_out(train)
    @train.delete(train)
  end
  
  def held_volume
    @volume.first
  end
  
  def free_volume
    @volume.last - @volume.first
  end

  private
  #методы нижестоящие пока не испоьзуем

  def info
    puts "Тип: #{@type}."
    print 'Номер поезда: '
    puts "#{@train.nil? ? 'Не прицеплен' : @train.number}"
  end

  def validate!
    raise "Введён неправильный номер вагона!\n\n" if number !~ VALID_NAME_WAGON
    raise "Такой номер уже есть!\n\n" if @@all_wagon[number]
    raise "Количество мест или объем не может быть пустым\n\n" if volume.last.nil?
    raise "Количество мест или объем не может быть нулевым или отрицательным\n\n" unless volume.last.positive?
  end

end
