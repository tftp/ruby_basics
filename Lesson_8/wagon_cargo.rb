# frozen_string_literal: true

# class for cargo wagons
class WagonCargo < Wagon
  def initialize(number, amount)
    super number, amount
    @type = :cargo
  end

  def add_cargo(volume)
    self.volume_held += volume unless volume_held + volume > volume_free
  end

  def del_cargo(volume)
    self.volume_held -= volume unless self.volume_held.negative?
  end
end
