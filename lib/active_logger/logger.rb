# frozen_string_literal: true

module ActiveLogger
  module Logger # :nodoc:
    module_function

    include ActiveLogger::Helpers::Base
    include ActiveLogger::Helpers::Appender

    class AppenderNotFound < StandardError; end
    class FilenameNotSpecified < StandardError; end

    def new(*args, &block)
      # extract options
      options = args.last.is_a?(Hash) ? args.pop : {}

      reset!

      if block_given?
        block.arity.positive? ? block.call(self) : instance_eval(&block)
      else
        type = args.first
        appender(type, options)
      end

      assign_appenders = appenders.drop(1)
      loggers = assign_appenders.inject(appenders[0]) { |appender, acc| acc.extend(ActiveSupport::Logger.broadcast(appender)) }
      TaggedLogging.new(loggers)
    end

    def loggable(type, options = {})
      parameters = []

      case type
      when :stdout, STDOUT
        parameters << STDOUT
      when :stderr, STDERR
        parameters << STDERR
      when String, Pathname
        parameters = [type.to_s, options[:keep], options[:size]]
      when :file
        raise FilenameNotSpecified if options[:filename].nil?

        parameters = [options[:filename], options[:keep], options[:size]]
      else
        raise AppenderNotFound
      end

      logger = ActiveSupport::Logger.new(*parameters)
      logger
    end
  end
end
