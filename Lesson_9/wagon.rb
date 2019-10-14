# frozen_string_literal: true

class Wagon
  include Validation
  include CompanyName

  VALID_NAME_WAGON = /^\d{3}$/.freeze
  @@all_wagon = {}
  attr_reader :number, :type, :train
  attr_accessor :volume_free, :volume_held

  def self.all
    @@all_wagon
  end

  def initialize(number, amount)
    @volume_held = 0
    @volume_free = amount.abs
    @number = number
    self.class.validate :number, :format,  VALID_NAME_WAGON
    self.class.validate :number, :compare
    self.class.validate :volume_free, :presence
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
    @volume_held
  end

  def free_volume
    @volume_free - @volume_held
  end

  private

  def info
    puts "Тип: #{@type}."
    print 'Номер поезда: '
    puts @train.nil? ? 'Не прицеплен' : @train.number
  end

  def validate!
    raise "Введён неправильный номер вагона!\n\n" if number !~ VALID_NAME_WAGON
    raise "Такой номер уже есть!\n\n" if @@all_wagon[number]
    raise "Колчество мест или объем не может быть пустм\n\n" if volume_free.nil?

    unless volume_free.positive?
      raise "Количество мест или объем не може быть нулевм или отрицателным\n\n"
    end
  end
end
