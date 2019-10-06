class WagonPass < Wagon

  def initialize (number, amount)
    super number, amount
    @type = :pass
  end

  def add_passenger
    self.volume_held += 1 if self.volume_held < self.volume_free
  end

  def del_passenger
    self.volume_held -= 1 if self.volume_held.positive?
  end

end
