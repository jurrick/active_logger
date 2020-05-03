# frozen_string_literal: true

module ActiveLogger
  module Appenders # :nodoc:
    class NotFound < StandardError; end

    @appenders = {}

    def self.register(name, klass)
      @appenders[name.to_sym] = klass
    end

    def self.new(type, options)
      appender =
        case type
        when STDOUT then @appenders[:stdout]
        when STDERR then @appenders[:stderr]
        else @appenders[type]
        end

      raise NotFound, type if appender.nil?

      appender.new(options)
    end
  end
end
