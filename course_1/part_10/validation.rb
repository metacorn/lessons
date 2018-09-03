module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, validation_type, *additional)
      @validations ||= []
      var_name = "@#{attr_name}".to_sym
      validation_method_name = "#{validation_type}_validation"
      compare_sample = additional[0]
      current_validation = [validation_method_name, var_name, compare_sample]
      @validations << current_validation
    end
  end

  module InstanceMethods
    def validate!(*additional_msg)
      validations = self.class.validations
      validations.each do |validation|
        validation_method_name, var_name, compare_sample = validation
        attribute = instance_variable_get(var_name)
        send(validation_method_name, var_name, attribute, compare_sample)
      end
    end

    def presence_validation(var_name, attribute, compare_sample)
      raise "Attribute #{var_name} could not be Nil!" if attribute.nil?
      raise "Attribute could not be empty String!" if attribute == ""
    end

    def format_validation(var_name, attribute, compare_sample)
      pattern = compare_sample
      if attribute !~ pattern
        raise "Attribute #{var_name} should conform to the pattern: " \
        "#{compare_sample.inspect}!"
      end
    end

    def type_validation(var_name, attribute, compare_sample)
      attr_class = compare_sample
      if attribute.class != attr_class
        raise "Attribute #{var_name} has wrong class " \
        "(#{attribute.class}), should be #{attr_class}!"
      end
    end

    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end
  end
end
