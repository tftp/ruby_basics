class TrainCargo < Train

  def initialize (name)
    super (name)
    @type = :cargo
  end

end
