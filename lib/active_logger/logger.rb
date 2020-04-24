# frozen_string_literal: true

module ActiveLogger
  module Logger # :nodoc:
    module_function

    include ActiveLogger::Helpers::Base
    include ActiveLogger::Helpers::Level
    include ActiveLogger::Helpers::Formatter
    include ActiveLogger::Helpers::Appender

    def new(*args, &block)
      # extract options
      options = args.last.is_a?(Hash) ? args.pop : {}

      reset!

      self.formatter = options[:formatter] unless options[:formatter].nil?
      self.level = options[:level] unless options[:level].nil?
      self.progname = options[:progname] unless options[:progname].nil?

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
  end
end
