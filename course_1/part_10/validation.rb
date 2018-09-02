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
      method_name = "#{validation_type}_validation"
      compare_sample = additional[0]
      current_validation = [method_name, var_name, compare_sample]
      @validations << current_validation
    end
  end

  module InstanceMethods
    def validate!(*additional_msg)
      if [Train, Wagon].include? self.class.superclass
        validations = self.class.superclass.validations
      else
        validations = self.class.validations
      end
      validation_msg = ""
      validations.each do |validation|
        method_name, var_name, compare_sample = validation
        answer = send(method_name, var_name, compare_sample)
        validation_msg += answer.concat(" ")
      end
      validation_msg += additional_msg[0] if !additional_msg.empty?
      validation_msg.lstrip!.rstrip!
      raise validation_msg if !validation_msg.empty?
    end

    def presence_validation(var_name, compare_sample)
      attribute = instance_variable_get(var_name)
      if attribute.nil?
        return "Attribute #{var_name} could not be Nil!"
      elsif attribute == ""
        return "Attribute #{var_name} could not be empty String!"
      else
        return ""
      end
    end

    def format_validation(var_name, compare_sample)
      attribute = instance_variable_get(var_name)
      pattern = compare_sample
      if attribute !~ pattern
        return "Attribute #{var_name} should conform to the pattern: " \
        "#{compare_sample.inspect}!"
      else
        return ""
      end
    end

    def type_validation(var_name, compare_sample)
      attribute = instance_variable_get(var_name)
      attr_class = compare_sample
      if attribute.class != attr_class
        return "Attribute #{var_name} has wrong class " \
        "(#{attribute.class}), should be #{attr_class}!"
      else
        return ""
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
