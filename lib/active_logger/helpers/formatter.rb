# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Formatter #:nodoc:
      extend ActiveSupport::Concern

      class FormatterNotFound < StandardError; end

      class_methods do
        def formatter=(formatter)
          @__formatter__ =
            case formatter
            when :default then ActiveLogger::Formatters::Default.new
            when :json then ActiveLogger::Formatters::Json.new
            when :syslog then ActiveLogger::Formatters::Syslog.new
            else
              raise FormatterNotFound unless formatter.class.ancestors.include?(ActiveLogger::Formatters::Base)

              formatter
            end
        end

        def formatter
          @__formatter__
        end

        private

        def reset!
          @__formatter__ = nil

          super if defined?(super)
        end
      end
    end
  end
end
