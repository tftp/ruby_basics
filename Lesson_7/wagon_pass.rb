class WagonPass < Wagon

  def initialize (number, amount)
    super number, amount
    @type = :pass
  end
  
  def add_passenger
    self.volume[0] += 1 if self.volume.first < self.volume.last
  end

  def del_passenger
    self.volume[0] -= 1 if self.volume.first.positive?
  end

end
