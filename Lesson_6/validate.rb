module Validate
  def validate?
    validate!
    true
  rescue => e
    puts e.message
    false
  end
end
