class WagonCargo < Wagon

  def initialize (number, amount)
    super number, amount
    @type = :cargo
  end

  def add_cargo(volume)
    self.volume[0] += volume unless self.volume.first + volume > self.volume.last
  end

  def del_cargo(volume)
    self.volume[0] -= volume unless self.volume.first.negative?
  end

end
