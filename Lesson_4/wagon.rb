class Wagon
  attr_reader :number, :type, :train

  def initialize(number)
    @type
    @number = number
    @train = []
  end

  protected
  #нижестоящие методы можно использовать в подклассах

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

end
