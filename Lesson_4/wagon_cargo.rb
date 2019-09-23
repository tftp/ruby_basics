class WagonCargo < Wagon

  def initialize (number)
    super (number)
    @type = :cargo
  end

end
