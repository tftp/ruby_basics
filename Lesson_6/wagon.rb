class Wagon
  include CompanyName
  VALID_NAME_WAGON = /^\d{3}$/
  @@all_wagon = {}
  attr_reader :number, :type, :train

  def initialize(number)
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
  end

end
