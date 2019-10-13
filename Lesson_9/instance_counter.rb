# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend(ClassMethods)
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @all_instances&.count
    end

    def instances_increment(instance)
      @all_instances ||= []
      @all_instances << instance
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances_increment(self)
    end
  end
end
