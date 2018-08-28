module Accessors
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        define_history(name)
        define_setter(name, var_name)
        define_getter(name, var_name)
      end
    end

    private

    def define_history(name)
      var_history_name = "@#{name}_history".to_sym
      puts var_history_name.inspect
      instance_variable_set(var_history_name, [])
      define_method("#{name}_history") { instance_variable_get(var_history_name) }
    end

    def define_setter(name, var_name)
      define_method("#{name}=") do |value|
        instance_variable_set(var_name, value)
  #      instance_variable_get("@#{name}_history".to_sym) << value
      end
    end

    def define_getter(name, var_name)
      define_method(name) { instance_variable_get(var_name) }
    end
  end

  module InstanceMethods
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :c
end
