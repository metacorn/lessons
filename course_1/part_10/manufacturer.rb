require_relative 'accessors.rb'

module Manufacturer
  include Accessors

  attr_accessor_with_history :manufacturer
end
