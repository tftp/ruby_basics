class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @train = []
  end

  def train_in(train)
    @train << train
  end

  def train_out(train)
    @train.delete(train)
  end

  def output
    return if @train.empty?
    puts "Список поездов на станции  #{@name}:"
    @train.each do |train|
          puts "Поезд номер #{train.number}, тип: #{train.type}"
    end
  end

  def output_type
    return if @train.empty?
    number_pass = 0
    number_carg = 0
    @train.each do |ob|
      ob.type == 'грузовой' ? number_carg +=1 : number_pass += 1
    end
    puts "Грузовых поездов на станции: #{number_carg}"
    puts "Пассажирских поездов на станции: #{number_pass}"
  end

end
