module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      var_name = "@#{name}".to_sym
      var_array = "@var_array".to_sym
      value = instance_variable_get(var_array)
      if value.nil?
        instance_variable_set(var_array, [[var_name, args]])
      else
        instance_variable_set(var_array, value.push([var_name, args]))
      end
    end
  end

  module InstanceMethods
    def validate!
      var_array = "@var_array".to_sym
      self.class.instance_variable_get(var_array).uniq.each do |key|
        value = instance_variable_get(key.first)
        value_type = key[1][0]
        value_arg = key[1][1]
        if self.class.class_variables[0]
          value_compare = self.class.class_variable_get(self.class.class_variables[0])
        end
        self.public_send(value_type, value, value_arg, value_compare)
      end
    end

    def validate?
      begin
        validate!
        return true
      rescue => e
        puts e.message
        return false
      end
    end

    def presence(*args)
      value = args[0]
      if value.nil? || (value.empty? if value.methods.include?(:empty))
        raise "Nil or empty! Can't be nil or empty!"
      end
    end

    def format (*args)
      value = args[0]
      data = args[1]
      raise "Format mismatch! For #{value}" unless value =~ data
    end

    def type(*args)
      value = args[0]
      data = args[1]
      unless value.class == data
        raise "Type mismatch! Input #{value}. Must be #{data}"
      end
    end

    def compare(*args)
      value = args[0]
      value_compare = args[2]
      raise "This name or number already exists\n\n" if value_compare.has_key? value
    end

  end
end
