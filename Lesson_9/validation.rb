module Validation
  def validate(name, *args)
    var_name = "@#{name}".to_sym
    var_hash = "@var_hash".to_sym
    if instance_variable_get(var_hash).nil?
      instance_variable_set(var_hash, [[var_name, args]])
    else
      instance_variable_set(var_hash, instance_variable_get(var_hash).push([var_name, args]))
    end
    define_method(:validate!) do
      self.class.instance_variable_get(var_hash).each do |key|
        puts key.inspect
        case key.last.first
        when :presence
          value = instance_variable_get(key.first)
          raise 'Nil or empty!' if value.nil? || (value.empty? if value.methods.include?(:empty))
        end
      end
    end
  end
end
