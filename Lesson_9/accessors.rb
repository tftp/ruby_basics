# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_name_history) }
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
        if instance_variable_get(var_name_history).nil?
          instance_variable_set(var_name_history, [value])
        else
          instance_variable_set(var_name_history, instance_variable_get(var_name_history) << value)
        end
      end
    end
  end

  def strong_attr_accessor(name, class_value)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=") do |value|
      raise 'Wrong class variable!' unless value.class == class_value

      instance_variable_set(var_name, value)
    end
  end
end
