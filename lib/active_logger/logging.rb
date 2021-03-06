# frozen_string_literal: true

module ActiveLogger
  module Logging # :nodoc:
    module_function

    include ActiveLogger::Helpers::Base
    include ActiveLogger::Helpers::Level
    include ActiveLogger::Helpers::Formatter
    include ActiveLogger::Helpers::Appender

    def new(*args, &block)
      # extract options
      options = args.last.is_a?(Hash) ? args.pop : {}

      reset!

      self.formatter = options.delete(:formatter) if options[:formatter]
      self.level = options.delete(:level) if options[:level]
      self.progname = options.delete(:progname) if options[:progname]
      self.name = options.delete(:name) if options[:name]

      if block_given?
        block.arity.positive? ? block.call(self) : instance_eval(&block)
      else
        type = args.first
        appender(type, options)
      end

      assign_appenders = appenders.drop(1)
      loggers = assign_appenders.inject(appenders[0]) { |appender, acc| acc.extend(ActiveSupport::Logger.broadcast(appender)) }
      logger = TaggedLogging.new(loggers)
      ActiveLogger::Repository[name] = logger unless autogenerated_name?
      logger
    end
  end
end
