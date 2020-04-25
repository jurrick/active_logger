# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Appender #:nodoc:
      extend ActiveSupport::Concern

      class AppenderNotFound < StandardError; end
      class FilenameNotSpecified < StandardError; end

      class_methods do
        def appender(type, options = {})
          appenders << loggable(type, options)
        end

        def appenders
          @appenders ||= []
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

          logger = ActiveLogger::Logger.new(*parameters)
          logger.level = level
          logger.formatter = formatter
          logger.progname = progname
          logger
        end
      end
    end
  end
end
