# frozen_string_literal: true

module Validate
  def validate?
    validate!
    true
  rescue StandardError => e
    puts e.message
    false
  end
end
