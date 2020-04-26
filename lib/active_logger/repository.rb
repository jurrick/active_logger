# frozen_string_literal: true

require 'monitor'
require 'singleton'

module ActiveLogger
  class LoggerNotFound < StandardError # :nodoc:
    def message
      "Could not find a ActiveLogger::Logger instance with the name '#{super}'"
    end
  end

  class Repository # :nodoc:
    extend MonitorMixin
    include Singleton

    attr_reader :loggers

    def initialize
      @loggers = {}
    end

    def self.[]=(name, logger)
      synchronize { instance.loggers[name] = logger }
    end

    def self.[](name)
      synchronize do
        instance.__fetch__(name) || (raise ActiveLogger::LoggerNotFound, name)
      end
    end

    def self.loggers
      synchronize { instance.loggers }
    end

    def __fetch__(name)
      logger = loggers[name] || loggers[name.to_s]

      return __fetch__(name.superclass) if logger.nil? && name.respond_to?(:superclass)

      logger
    end
  end
end
