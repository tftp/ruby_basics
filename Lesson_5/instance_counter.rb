module InstanceCounter
  def self.included (base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  module ClassMethods

    def instances
      @all_instances.count
    end

    def instances_increment(instance)
      unless @all_instances
        @all_instances = []
        @all_instances << instance
      else
        @all_instances << instance
      end
    end
  end

  module InstanceMethods
#   private
#    @@instances = 0

    def register_instance
      self.class.instances_increment(self)
    end
  end

end
