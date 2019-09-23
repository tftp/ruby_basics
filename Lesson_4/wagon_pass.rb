class WagonPass < Wagon

  def initialize (number)
    super (number)
    @type = :pass
  end

end
