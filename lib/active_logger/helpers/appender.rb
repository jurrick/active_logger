# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Appender #:nodoc:
      extend ActiveSupport::Concern

      class_methods do
        def appender(type, options = {})
          appenders << loggable(type, options)
        end

        def appenders
          @appenders ||= []
        end

        def loggable(type, options = {})
          logger = ActiveLogger::Appenders.new(type, options)
          logger.level = level
          default_formatter = logger.respond_to?(:default_formatter) ? logger.default_formatter : ActiveLogger::Formatters::Default.new
          logger.formatter = formatter || default_formatter
          logger.progname = progname
          logger
        end
      end
    end
  end
end
