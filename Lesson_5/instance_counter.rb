module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end
  
  module ClassMethods
    def instances
      @all_instances.count if @all_instances
    end

    def instances_increment(instance)
      @all_instances ||= []
      @all_instances << instance
    end
  end

  module InstanceMethods

   protected
   #потому что участвуют подклассы 
    def register_instance
      self.class.instances_increment(self)
    end
  end

end
