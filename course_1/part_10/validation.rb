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
      attribute = instance_variable_get(var_name)
      validation_method_name = "#{validation_type}_validation"
      compare_sample = additional[0]
      current_validation = [validation_method_name, attribute, compare_sample]
      @validations << current_validation
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.validations
      validations.each do |validation|
        validation_method_name, attribute, compare_sample = validation
        send(validation_method_name, attribute, compare_sample)
      end
    end

    def presence_validation(attribute, compare_sample)
      if attribute.nil?
        raise "Attribute could not be Nil!"
      elsif attribute == ""
        raise "Attribute could not be empty String!"
      end
    end

    def format_validation(attribute, compare_sample)
      pattern = compare_sample
      if attribute !~ pattern
        raise "Attribute should conform to the pattern: " \
        "#{compare_sample.inspect}!"
      end
    end

    def type_validation(attribute, compare_sample)
      attr_class = compare_sample
      if attribute.class != attr_class
        raise "Attribute has wrong class " \
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
