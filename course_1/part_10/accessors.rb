module Accessors
  def self.included(base)
    base.extend ClassMethods
    # base.send :include, InstanceMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        var_history_name = "@#{name}_history".to_sym
        define_method("#{name}_history") do
          instance_variable_get(var_history_name)
        end
        define_method("#{name}=") do |value|
          instance_variable_set(var_name, value)
          var_history = instance_variable_get(var_history_name) || []
          var_history << value
          instance_variable_set(var_history_name, var_history)
        end
        define_method(name) { instance_variable_get(var_name) }
      end
    end

    def strong_attr_accessor(attr_name, attr_class)
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=") do |value|
        raise "Wrong class of value! It should be #{attr_class}!" if !value.instance_of?(attr_class)
        instance_variable_set(var_name, value)
      end
    end
  end
end

class Test
  include Accessors

  attr_accessor_with_history :a, :b, :c
  strong_attr_accessor :d, Array
end
