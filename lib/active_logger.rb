# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/logger'

module ActiveLogger # :nodoc:
  module_function

  def new(*args, &block)
    ActiveLogger::Logging.new(*args, &block)
  end
end

# Formatters
require File.dirname(__FILE__) + '/active_logger/formatters/base'
require File.dirname(__FILE__) + '/active_logger/formatters/default'
require File.dirname(__FILE__) + '/active_logger/formatters/json'

# Helpers
require File.dirname(__FILE__) + '/active_logger/helpers/base'
require File.dirname(__FILE__) + '/active_logger/helpers/level'
require File.dirname(__FILE__) + '/active_logger/helpers/formatter'
require File.dirname(__FILE__) + '/active_logger/helpers/appender'

require File.dirname(__FILE__) + '/active_logger/tagged_logging'
require File.dirname(__FILE__) + '/active_logger/logging'
require File.dirname(__FILE__) + '/active_logger/logger'
