# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/logger'

module ActiveLogger # :nodoc:
  module_function

  def new(*args, &block)
    ActiveLogger::Logger.new(*args, &block)
  end
end

# Helpers
require File.dirname(__FILE__) + '/active_logger/helpers/base'
require File.dirname(__FILE__) + '/active_logger/helpers/appender'

require File.dirname(__FILE__) + '/active_logger/logger'
