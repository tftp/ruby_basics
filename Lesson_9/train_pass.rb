# frozen_string_literal: true

# class for passenger trains
class TrainPass < Train
  def initialize(name)
    super name
    @type = :pass
  end
end
