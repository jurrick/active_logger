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

        private

        def reset!; end
      end
    end
  end
end
