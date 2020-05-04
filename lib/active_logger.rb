# frozen_string_literal: true

require 'active_support/concern'
require 'active_support/logger'

module ActiveLogger # :nodoc:
  module_function

  def new(*args, &block)
    ActiveLogger::Logging.new(*args, &block)
  end

  def [](name)
    ActiveLogger::Repository[name]
  end

  def []=(name, logger)
    ActiveLogger::Repository[name] = logger
  end
end

# Appenders
require File.dirname(__FILE__) + '/active_logger/appenders/base'
require File.dirname(__FILE__) + '/active_logger/appenders/file'
require File.dirname(__FILE__) + '/active_logger/appenders/streams'
require File.dirname(__FILE__) + '/active_logger/appenders/syslog'

# Formatters
require File.dirname(__FILE__) + '/active_logger/formatters/base'
require File.dirname(__FILE__) + '/active_logger/formatters/default'
require File.dirname(__FILE__) + '/active_logger/formatters/json'
require File.dirname(__FILE__) + '/active_logger/formatters/syslog'

# Helpers
require File.dirname(__FILE__) + '/active_logger/helpers/base'
require File.dirname(__FILE__) + '/active_logger/helpers/level'
require File.dirname(__FILE__) + '/active_logger/helpers/formatter'
require File.dirname(__FILE__) + '/active_logger/helpers/appender'

require File.dirname(__FILE__) + '/active_logger/tagged_logging'
require File.dirname(__FILE__) + '/active_logger/logging'
require File.dirname(__FILE__) + '/active_logger/logger'
require File.dirname(__FILE__) + '/active_logger/repository'
require File.dirname(__FILE__) + '/active_logger/appenders'

ActiveLogger::Appenders.register(:stdout, ActiveLogger::Appenders::Stdout)
ActiveLogger::Appenders.register(:stderr, ActiveLogger::Appenders::Stderr)
ActiveLogger::Appenders.register(:file, ActiveLogger::Appenders::File)
ActiveLogger::Appenders.register(:syslog, ActiveLogger::Appenders::Syslog)
