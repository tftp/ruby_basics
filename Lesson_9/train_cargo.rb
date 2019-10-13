# frozen_string_literal: true

# class for cargo train
class TrainCargo < Train
  def initialize(name)
    super name
    @type = :cargo
  end
end
