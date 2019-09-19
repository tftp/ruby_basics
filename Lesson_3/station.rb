class Station

  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_in(train)
    @trains << train
  end

  def train_out(train)
    @trains.delete(train)
  end

  def output
    return if @trains.empty?
    puts "Список поездов на станции  #{@name}:"
    @trains.each do |train|
          puts "Поезд номер #{train.number}, тип: #{train.type}"
    end
  end

  def output_type(type)
    number_type = @trains.count{|train| train.type == type}
    puts "Поездов типа #{type} на станции: #{number_type}"
  end

end
