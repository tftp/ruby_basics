module Validation
  def validate(name, *args)
    var_name = "@#{name}".to_sym
    var_hash = "@var_hash".to_sym
    value = instance_variable_get(var_hash)
    if value.nil?
      instance_variable_set(var_hash, [[var_name, args]])
    else
      instance_variable_set(var_hash, value.push([var_name, args]))
    end

    define_method(:validate!) do
      self.class.instance_variable_get(var_hash).uniq.each do |key|
        value = instance_variable_get(key.first)
        value_compare = self.class.class_variable_get(self.class.class_variables[0])
#        puts "#{key.inspect}"
#        puts "#{value}"
#        puts "#{value_compare}"
        case key.last.first
        when :presence
          if value.nil? || (value.empty? if value.methods.include?(:empty))
            raise "Nil or empty! #{key.first} can't be nil or empty!"
          end
        when :type
          unless value.class == key[1][1]
            raise "Type mismatch! for #{key.first}=#{value}. Must be #{key[1][1]}"
          end
        when :format
          raise "Format mismatch! For #{key.first}=#{value}" unless value =~ key[1][1]
        when :compare
          raise "This name or number already exists\n\n" if value_compare.has_key? value
        end
      end
    end

    define_method(:validate?) do
      begin
        validate!
        return true
      rescue => e
        puts e.message
        return false
      end
    end

  end

end
